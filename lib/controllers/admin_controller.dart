// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/competitions/money_bag.dart';
import '../models/users/recruitment_history.dart';
import '../models/users/abstract_user.dart';

import '../models/competitions/activation_request.dart';
import '../models/converter.dart';
import '../models/locations/town_or_institution.dart';
import '../models/users/admin.dart';
import '../screens/utils/globals.dart';
import 'dart:math';
import 'dart:developer' as debug;

import 'language_controller.dart';

enum AdminSavingStatus {
  invalidInput,
  incompleteData,
  adminAlreadyExist,
  loginRequired,
  unathourized,
  saved,
}

enum RecruitmentHistorySavingStatus {
  loginRequired,
  blocked,
  unauthorized,
  notSaved,
  saved,
}

class AdminController extends GetxController {
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  AdminController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  static AdminController adminController = Get.find();
  LanguageController languageController = LanguageController.languageController;

  final adminEntranceCode = 'alco-prod';

  // Superior Admin
  Rx<String> _moneyCollectorInfo = Rx(
    '+27611111111 @Mayville wulep0IRp6frpI3CzqaxGUxTKBb2',
  );
  String get moneyCollectorInfo => _moneyCollectorInfo.value;

  Rx<AdminType> _newAdminType = Rx(AdminType.groupRegistery);
  AdminType get newAdminType => _newAdminType.value;

  Rx<Admin?> _currentlyLoggedInAdmin = Rx(null);
  Admin? get currentlyLoggedInAdmin => _currentlyLoggedInAdmin.value;

  late Rx<String?> _newAdminUserId = Rx(null);
  String? get newAdminUserId => _newAdminUserId.value;

  late Rx<File?> _newAdminProfileImage = Rx(null);
  File? get newAdminProfileImage => _newAdminProfileImage.value;

  late Rx<String> _newAdminProfileImageURL = Rx('');
  String get newAdminProfileImageURL => _newAdminProfileImageURL.value;

  late Rx<String?> _newAdminPhoneNumber = Rx(null);
  String? get newAdminPhoneNumber => _newAdminPhoneNumber.value;

  late Rx<TownOrInstitution> _newTownOrInstitutionName = Rx(
    TownOrInstitution.howardUKZN,
  );
  TownOrInstitution get newTownOrInstitutionName =>
      _newTownOrInstitutionName.value;

  late Rx<bool> _newAdminIsFemale = Rx(true);
  bool get newAdminIsFemale => _newAdminIsFemale.value;

  late Rx<String> _newAdminPassword = Rx('');
  String get newAdminPassword => _newAdminPassword.value;

  late Rx<String?> _superiorAdminEntranceCode = Rx<String?>(null);
  String? get superiorAdminEntranceCode => _superiorAdminEntranceCode.value;

  void setNewAdimPhoneNumber(String phoneNumber) {
    _newAdminPhoneNumber = Rx(phoneNumber);
  }

  void setNewTownOrInstitutionName(TownOrInstitution townOrInstitutionName) {
    _newTownOrInstitutionName = Rx<TownOrInstitution>(townOrInstitutionName);
  }

  void setNewAdminIsFemale(bool isFemale) {
    _newAdminIsFemale = Rx<bool>(isFemale);
    update();
  }

  void setNewAdminType(AdminType adminType) {
    _newAdminType = Rx(adminType);
    update();
  }

  void setMoneyCollectorInfo(String moneyCollectorInfo) {
    _moneyCollectorInfo = Rx(moneyCollectorInfo);
    update();
  }

  // Clear for new admin registration.
  void clear() {
    _newAdminUserId = Rx<String?>(null);
    _newAdminProfileImage = Rx(null);
    _newAdminProfileImageURL = Rx('');
    _newAdminPhoneNumber = Rx(null);
    _newTownOrInstitutionName = Rx(TownOrInstitution.howardUKZN);
    _newAdminIsFemale = Rx(true);
    _newAdminPassword = Rx('');
    update();
  }

  Future<Admin?> findAdmin(String userId) {
    debug.log('Admin\'s userId $userId from findAdmin @adminController');
    return firestore.collection('admins').doc(userId).get().then((value) {
      return value.exists ? Admin.fromJson(value.data()) : null;
    });
  }

  /*
  Future<Admin?> findAdmin2(String phoneNumber) {
    debug.log(
      'Admin\'s phoneNumber $phoneNumber from findAdmin @adminController',
    );
    return firestore
        .collection('admins')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .count()
        .get()
        .then((value) {
          if (value.count == 1) {
            debug.log('value.count == 1');
            value.query.get().then((onValue) {
              onValue.docs.map((element) {
                Admin admin = Admin.fromJson(element);
                debug.log('Admin Found \n${admin.toString()}');
                return admin;
              });
            });
          } else {
            debug.log('value.count != 1');
            return null;
          }
        });
  }
  */
  void loginAdminUsingObject(Admin admin) {
    _currentlyLoggedInAdmin = Rx(admin);
    auth.authStateChanges();
    languageController.setLanguage(admin.townOrInstitution);
  }

  void logoutAdmin() async {
    await auth.signOut();
    _currentlyLoggedInAdmin = Rx(null);
  }

  void chooseAdminProfileImageFromGallery(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Phone Number Is Required Before Picking An Image.',
      );
    } else if (!isValidPhoneNumber(phoneNumber)) {
      Get.snackbar('Error', 'Phone Number Is Invalid.');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImageFile != null) {
        _newAdminProfileImage = Rx<File?>(File(pickedImageFile.path));
        _newAdminProfileImageURL = Rx<String>(
          await uploadResource(
            _newAdminProfileImage.value!,
            '/admins/profile_images/$phoneNumber',
          ),
        );
        _newAdminPhoneNumber = Rx<String?>(phoneNumber);
        Get.snackbar('Image Status', 'Image File Successfully Picked.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Picked.');
      }
    }
  }

  void captureAdminProfileImageWithCamera(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Phone Number Is Required Before Picking An Image.',
      );
      debug.log('Phone Number Is Required Before Picking An Image.');
    } else if (!isValidPhoneNumber(phoneNumber)) {
      Get.snackbar('Error', 'Phone Number Is Invalid.');
      debug.log('Phone Number Is Invalid');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImageFile != null) {
        _newAdminProfileImage = Rx<File?>(File(pickedImageFile.path));
        _newAdminProfileImageURL = Rx<String>(
          await uploadResource(
            _newAdminProfileImage.value!,
            '/admins/profile_images/$phoneNumber',
          ),
        );
        _newAdminPhoneNumber = Rx<String?>(phoneNumber);

        debug.log('Image File Successfully Picked');
        Get.snackbar('Image Status', 'Image File Successfully Picked.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Picked.');
        debug.log('Image Wasn\'t Picked.');
      }
    }
  }

  void setAdminPassword(String password) {
    _newAdminPassword = Rx(password);
  }

  bool isCorrectSuperiorAdminEntrancePassword() {
    return _superiorAdminEntranceCode.value != null &&
        _superiorAdminEntranceCode.value!.contains(adminEntranceCode) &&
        adminEntranceCode.contains(_superiorAdminEntranceCode.value!);
  }

  void setSuperiorAdminEntranceCode(String superiorAdminEntranceCode) {
    if (superiorAdminEntranceCode.contains(adminEntranceCode) &&
        adminEntranceCode.contains(superiorAdminEntranceCode)) {
      _superiorAdminEntranceCode = Rx<String?>(superiorAdminEntranceCode);
      update();
    }
  }

  Future<void> saveMoneyBag(Map<String, String> relationships) async {
    String moneyCollectorAdminFK = _moneyCollectorInfo.value.split(' ')[2];

    MoneyBag moneyBag = MoneyBag(
      moneyCollectorBagId: moneyCollectorAdminFK, // Reciever of the bag.
      senderSuperiorAdminFK: auth.currentUser!.uid,
      relationships: relationships,
    ); // Key: +27734476372 ajhflalhjafjhlkaf Value: yellow

    DocumentReference moneyBagReference = firestore
        .collection('money_bags')
        .doc(moneyCollectorAdminFK);

    if (relationships.isNotEmpty) {
      await moneyBagReference.set(moneyBag.toJson());
      relationships.clear();
    }
  }

  Future<void> submitMoneyBag() async {
    AbstractUser? currentlyLoggedInUser = getCurrentlyLoggenInUser();

    if (currentlyLoggedInUser == null || currentlyLoggedInUser is! Admin) {
      return;
    }

    DocumentReference reference = firestore
        .collection('money_bags')
        .doc(currentlyLoggedInUser.userId);
    await reference.update({'hasMoneyCollectorSubmitted': true});

    await reference.get().then((docSnapshot) async {
      DocumentReference storedMoneyBagReference = firestore
          .collection('stored_money_bags')
          .doc();
      await storedMoneyBagReference.set(docSnapshot.data());
    });

    await reference.delete();
  }

  // Only Called By Logged In Users.
  Stream<DocumentSnapshot<Object?>> retrieveMoneyBag() {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('money_bags')
        .doc(auth.currentUser!.uid);

    return reference.snapshots();
  }

  Future<void> updateActivationRequestColorState(
    String groupFK,
    String activationRequestId,
    String newColor,
  ) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('money_bags')
        .doc(auth.currentUser!.uid);

    await reference.update({
      'relationships.$groupFK $activationRequestId': newColor,
    });

    reference = FirebaseFirestore.instance.collection('groups').doc(groupFK);
    if (newColor == 'green') {
      await reference.update({'isActive': true});
    } else {
      await reference.update({'isActive': false});
    }
  }

  /*
  Future<void> approveOrDisapproveActivationRequest(
      groupId, bool? action) async {
    my.User? currentlyLoggedInUser = getCurrentlyLoggenInUser();

    if (currentlyLoggedInUser == null || currentlyLoggedInUser is! Admin) {
      return;
    }

    DocumentReference reference = firestore.collection('groups').doc(groupId);

    reference.get().then((value) async {
      if (value.exists) {
        DateTime requestDate = DateTime(
          value.get('activationRequest.requestDate.year'),
          value.get('activationRequest.requestDate.month'),
          value.get('activationRequest.requestDate.day'),
          value.get('activationRequest.requestDate.hour'),
          value.get('activationRequest.requestDate.minute'),
          value.get('activationRequest.requestDate.second'),
        );

        ActivationRequest activationRequest = ActivationRequest(
            activationRequestId:
                value.get('activationRequest.activationRequestId'),
            voucherType: Converter.toVoucherType(
                value.get('activationRequest.voucherType')),
            requestDate: requestDate,
            isApproved: value.get('activationRequest.isApproved'),
            groupFK: value.get('activationRequest.groupFK'),
            groupCreatorImageURL:
                value.get('activationRequest.groupCreatorImageURL'),
            voucher: value.get('activationRequest.voucher'));

        activationRequest.setIsApproved(action);
        await value.reference
            .update({"activationRequest": activationRequest.toJson()}).then(
                (value) async {
          reference = firestore
              .collection('activation_requests')
              .doc(activationRequest.activationRequestId);

          await reference.update({"isApproved": action});
          update();
        });
      } else {
        getSnapbar('No Such Group', 'Group Do Not Exist');
      }
    });
  } */

  Future<RecruitmentHistorySavingStatus> saveRecruitmentHistory(
    String groupId,
    bool? addingTo,
  ) async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      getSnapbar('Unauthorized', 'Update Failed, Login Required.');
      return RecruitmentHistorySavingStatus.loginRequired;
    } else if ((user is Admin) == false) {
      getSnapbar('Unauthorized', 'Only Admins May Add/Remove Groups.');
      return RecruitmentHistorySavingStatus.unauthorized;
    } else if ((user as Admin).isBlocked) {
      getSnapbar(
        'Admin Blocked',
        'You Are No Longer Allowed To Add/Remove Groups.',
      );
      return RecruitmentHistorySavingStatus.blocked;
    } else {
      // Throw An Exception If The Group Does Not Exist.
      String action;

      if (addingTo == null) {
        action = "None";
      } else if (addingTo == false) {
        action = "Removed Group";
      } else {
        action = "Added Group";
      }

      DocumentReference reference = firestore
          .collection('recruitment_history')
          .doc();

      RecruitmentHistory recruitmentHistory = RecruitmentHistory(
        adminPhoneNumber: user.phoneNumber,
        historyId: reference.id,
        action: action,
      );

      await reference.set(recruitmentHistory.toJson());
      return RecruitmentHistorySavingStatus.saved;
    }
  }

  // Supposed to read activation requests that we created in the past 7 days.
  Stream<List<ActivationRequest>>
  readNotYetSentToMoneyCollectorsActivationRequests() {
    Stream<List<ActivationRequest>> stream = firestore
        .collection('activation_requests')
        .where('moneyCollectorFK', isNull: true)
        // .where('isChecked', isEqualTo: false)
        /*.where("requestDate",
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(const Duration(days: 7))) */
        .snapshots()
        .map((snapshot) {
          List<ActivationRequest> list = snapshot.docs.map((doc) {
            ActivationRequest request = ActivationRequest.fromJson(doc.data());
            return request;
          }).toList();

          list.sort();
          return list;
        });

    return stream;
  }

  Stream<List<Admin>> readNotAdminType(AdminType adminType) {
    Stream<List<Admin>> stream = firestore
        .collection('admins')
        .where(
          'adminType',
          isNotEqualTo: Converter.toAdminTypeAsString(adminType),
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            Admin admin = Admin.fromJson(doc.data());
            return admin;
          }).toList(),
        );

    return stream;
  }

  Stream<List<Admin>> readAdmins() {
    Stream<List<Admin>> stream = firestore
        .collection('admins') /*
        .where('townOrInstitution',
            isEqualTo:
                Converter.townOrInstitutionAsString(newTownOrInstitutionName)) */
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            Admin admin = Admin.fromJson(doc.data());
            return admin;
          }).toList(),
        );

    return stream;
  }

  Future<AdminSavingStatus> saveAdmin(String phoneNumber) async {
    if (currentlyLoggedInAdmin == null) {
      return AdminSavingStatus.loginRequired;
    }

    /*if (_newAdminUserId.value == null) {
      return AdminSavingStatus.incompleteData;
    } */

    DocumentReference adminReference = firestore
        .collection('admins')
        .doc(/*_newAdminUserId.value*/);

    debug.log('Admin Document Reference Created...');

    return adminReference
        .snapshots()
        .map((adminDoc) async {
          if (currentlyLoggedInAdmin == null) {
            debug.log('Login required');
            return AdminSavingStatus.loginRequired;
          }

          if (!(currentlyLoggedInAdmin as Admin).isSuperior) {
            debug.log('Unathourized');
            return AdminSavingStatus.unathourized;
          }

          if (_newAdminPhoneNumber.value != null &&
              (!isValidPhoneNumber(_newAdminPhoneNumber.value!) ||
                  newAdminPassword.isEmpty)) {
            debug.log('Invalid input ${_newAdminPhoneNumber.value!}');
            return AdminSavingStatus.invalidInput;
          }

          if (_newAdminProfileImage.value == null ||
              _newAdminProfileImageURL.value.isEmpty ||
              _newAdminPhoneNumber.value == null) {
            debug.log('Incomplete Data');
            return AdminSavingStatus.incompleteData;
          }

          if (!adminDoc.exists) {
            String characters =
                'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            Random random = Random();
            DateTime joinedOn = DateTime.now();

            String key = '';
            key += characters[random.nextInt(characters.length)];
            key += characters[random.nextInt(characters.length)];
            key += characters[random.nextInt(characters.length)];

            Admin admin = Admin(
              userId: adminReference.id,
              adminType: _newAdminType.value,
              joinedOn: joinedOn,
              phoneNumber: _newAdminPhoneNumber.value,
              profileImageURL: _newAdminProfileImageURL.value,
              key: key,
              isFemale: _newAdminIsFemale.value,
              isSuperior: false,
              password: _newAdminPassword.value,
            );
            debug.log('Admin Document About To Be Saved');
            await adminReference.set(admin.toJson());
            loginAdminUsingObject(admin);
            clear();
            debug.log('Added To Collection...');
            return AdminSavingStatus.saved;
          } else {
            debug.log('Admin Document Already Exist');
            return AdminSavingStatus.adminAlreadyExist;
          }
        })
        .first
        .then((value) => value);
  }

  Future<void> blockOrUnblockAdmin(String phoneNumber, bool action) async {
    DocumentReference reference = firestore
        .collection('admins')
        .doc(phoneNumber);

    reference.get().then((value) async {
      if (value.exists) {
        debug.log('About To Block Admin...');
        await value.reference.update({"isBlocked": action});
      } else {
        getSnapbar('No Such Admin', 'Admin Do Not Exist');
      }
    });
  }
}
