import '../../models/locations/town_or_institution.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../models/competitions/won_price_summary.dart';
import '../models/converter.dart';
import '../models/users/abstract_user.dart';
import '../models/users/admin.dart';
import '../models/users/user.dart' as my;
import '../models/users/won_price_comment.dart';

import '../screens/utils/globals.dart';
import 'user_controller.dart';
import 'group_controller.dart';

// Branch : competition_resources_crud ->  competitions_data_access
class CompetitionController extends GetxController {
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  CompetitionController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  static CompetitionController competitionController = Get.find();
  GroupController groupController = GroupController.instance;
  UserController userController = UserController.userController;

  // Branch : won_price_summary_resources_crud ->  won_price_summary_resources_data_access
  Stream<List<WonPriceSummary>> readAllWonPriceSummaries() => FirebaseFirestore
      .instance
      .collection('won_prices_summaries')
      .snapshots()
      .map((wonPriceSummariesSnapshot) {
        List<WonPriceSummary> list = wonPriceSummariesSnapshot.docs.map((
          wonPriceSummaryDoc,
        ) {
          WonPriceSummary wonPriceSummary = WonPriceSummary.fromJson(
            wonPriceSummaryDoc.data(),
          );
          return wonPriceSummary;
        }).toList();
        list.sort();
        return list;
      });

  Stream<List<WonPriceSummary>> readAreaWonPriceSummaries(
    String townOrInstitutionFK,
  ) => FirebaseFirestore.instance
      .collection('won_prices_summaries')
      .where('groupArea.townOrInstitutionFK', isEqualTo: townOrInstitutionFK)
      .snapshots()
      .map((wonPriceSummariesSnapshot) {
        List<WonPriceSummary> list = wonPriceSummariesSnapshot.docs.map((
          wonPriceSummaryDoc,
        ) {
          WonPriceSummary wonPriceSummary = WonPriceSummary.fromJson(
            wonPriceSummaryDoc.data(),
          );
          return wonPriceSummary;
        }).toList();
        list.sort();
        return list;
      });

  // Branch : competition_resources_crud ->  competitions_data_access
  Stream<DocumentSnapshot>? findCompetition(String competitionId) {
    return FirebaseFirestore.instance
        .collection('competitions')
        .doc(competitionId)
        .snapshots();
  }

  // Branch : competition_resources_crud ->  competitions_data_access

  // Branch : competition_resources_crud ->  competitions_data_access
  Stream<DocumentSnapshot<Object?>> retrieveCountDownClock(
    String countDownClockId,
  ) {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('count_down_clocks')
        .doc(countDownClockId);

    return reference.snapshots();
  }

  Stream<List<WonPriceComment>> readWonPriceComments(
    String wonPriceSummaryFK,
  ) => firestore
      .collection('won_prices_summaries')
      .doc(wonPriceSummaryFK)
      .collection('comments')
      .snapshots()
      .map((commentsSnapshot) {
        List<WonPriceComment> list = commentsSnapshot.docs.map((commentDoc) {
          WonPriceComment comment = WonPriceComment.fromJson(commentDoc.data());
          return comment;
        }).toList();
        list.sort();
        return list;
      });

  Future<void> saveWonPriceComment(
    String wonPriceSummaryFK,
    String message,
  ) async {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      getSnapbar('Unauthorized Action', 'Login Before Commenting');
      return;
    }

    if (user is Admin) {
      getSnapbar('Unauthorized Action', 'Admins Cannot Comment');
      return;
    }

    DocumentReference wonPriceSummaryRef = firestore
        .collection('won_prices_summaries')
        .doc(wonPriceSummaryFK);

    wonPriceSummaryRef.get().then((wonPriceSummaryDoc) async {
      if (wonPriceSummaryDoc.exists) {
        WonPriceSummary wonPriceSummary = WonPriceSummary.fromJson(
          wonPriceSummaryDoc.data(),
        );

        int one = int.parse(
          wonPriceSummary.townOrInstitution.townOrInstitutionNo,
        );
        int two;

        TownOrInstitution townOrInstitution;
        townOrInstitution = Converter.toSupportedTownOrInstitution(
          (user as my.User).area.sectionName,
        ).townOrInstitutionName;
        two = int.parse(
          userController.currentlyLoggedInUser!.area.townOrInstitutionFK,
        );

        bool result = one == two;

        if (result) {
          DocumentReference commentReference = wonPriceSummaryRef
              .collection('comments')
              .doc();
          WonPriceComment? comment;
          if (userController.currentlyLoggedInUser != null) {
            comment = WonPriceComment(
              creatorPhoneNumber:
                  userController.currentlyLoggedInUser!.phoneNumber,
              wonPriceCommentId: commentReference.id,
              forTownOrInstitution: townOrInstitution,
              wonPriceSummaryFK: wonPriceSummaryFK,
              message: message,
              imageURL: userController.currentlyLoggedInUser!.profileImageURL,
              username: userController.currentlyLoggedInUser!.username,
            );
          }

          await commentReference.set(comment!.toJson());
        } else {
          String host = Converter.townOrInstitutionAsString(
            wonPriceSummary.townOrInstitution.townOrInstitutionName,
          );
          Get.snackbar('Error', 'Only $host Users May Comment.');
        }
      }
    });
  }
}
