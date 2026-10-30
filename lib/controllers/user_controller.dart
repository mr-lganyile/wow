import 'dart:io';
import 'dart:developer' as debug;

import '/controllers/language_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/converter.dart';
import '../models/locations/section_name.dart';
import '../models/locations/supported_area.dart';
import '../models/users/user.dart' as my;
import '../models/users/abstract_user.dart';
import '../screens/utils/globals.dart';

enum UserSavingStatus {
  incompleteData,
  adminAlreadyExist,
  loginRequired,
  unathourized,
  alcoholCreationError,
  saved,
}

class UserController extends GetxController {
  static UserController userController = Get.find();
  LanguageController languageController = LanguageController.languageController;

  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  UserController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  // ignore: prefer_final_fields
  Rx<my.User?> _currentlyLoggedInUser = Rx(null);
  my.User? get currentlyLoggedInUser => _currentlyLoggedInUser.value;

  // ignore: prefer_final_fields
  late Rx<String?> _newUserPhoneNumber = Rx('');
  String? get newUserPhoneNumber => _newUserPhoneNumber.value;

  // ignore: prefer_final_fields
  late Rx<String?> _newUserUsername = Rx('');
  String? get newUserUsername => _newUserUsername.value;

  // ignore: prefer_final_fields
  late Rx<SupportedArea> _newUserArea = Rx(
    Converter.toSupportedArea(
      SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica,
    ),
  );
  SupportedArea get newUserArea => _newUserArea.value;

  late Rx<File?> _newUserProfileImageFile;
  File? get newUserProfileImageFile => _newUserProfileImageFile.value;

  // ignore: prefer_final_fields
  late Rx<String?> _newUserImageURL = Rx('');
  String? get newUserImageURL => _newUserImageURL.value;

  // ignore: prefer_final_fields
  late Rx<String> _newUserPassword = Rx('');
  String get newUserPassword => _newUserPassword.value;

  Rx<SectionName?> locateableSectionName = Rx<SectionName>(
    SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica,
  );
  SectionName? get searchedSectionName => locateableSectionName.value;

  void setNewUserUsername(String username) {
    _newUserUsername = Rx(username);
  }

  void setNewUserPassword(String password) {
    _newUserPassword = Rx(password);
  }

  Future<my.User?> findUser(String userId) {
    return firestore.collection('users').doc(userId).get().then((value) {
      return value.exists ? my.User.fromJson(value.data()) : null;
    });
  }

  void loginUserUsingObject(my.User user) {
    _currentlyLoggedInUser = Rx(user);
    auth.authStateChanges();
    languageController.setLanguage(
      Converter.toSupportedTownOrInstitution(
        user.area.sectionName,
      ).townOrInstitutionName,
    );
  }

  void logoutUser() async {
    await auth.signOut();
    _currentlyLoggedInUser = Rx(null);
  }

  void captureUserProfileImageWithCamera(
    String phoneNumber,
    String username,
  ) async {
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Phone Number Is Required Before Capturing An Image.',
      );
      debug.log('Phone Number Is Required Before Capturing An Image.');
    } else if (username.isEmpty) {
      Get.snackbar('Error', 'Username Is Required Before Capturing An Image.');
      debug.log('Username Is Required Before Capturing An Image.');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImageFile != null) {
        String host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            _newUserArea.value.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        _newUserProfileImageFile = Rx<File?>(File(pickedImageFile.path));
        _newUserImageURL = Rx<String?>(
          await uploadResource(
            _newUserProfileImageFile.value!,
            '$host/users/profile_images/$phoneNumber',
          ),
        );
        _newUserPhoneNumber = Rx<String?>(phoneNumber);
        _newUserUsername = Rx<String?>(username);
        debug.log('Image File Successfully Captured.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
        debug.log('Image Wasn\'t Captured');
      }
    }
  }

  void chooseUserProfileImageFromGallery(
    String phoneNumber,
    String username,
  ) async {
    if (phoneNumber.isEmpty) {
      Get.snackbar(
        'Error',
        'Phone Number Is Required Before Capturing An Image.',
      );
      debug.log('Phone Number Is Required Before Capturing An Image');
    } else if (username.isEmpty) {
      Get.snackbar('Error', 'Username Is Required Before Capturing An Image.');
      debug.log('Username Is Required Before Capturing An Image');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImageFile != null) {
        _newUserProfileImageFile = Rx<File?>(File(pickedImageFile.path));
        String host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            _newUserArea.value.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        _newUserImageURL = Rx<String?>(
          await uploadResource(
            _newUserProfileImageFile.value!,
            '$host/users/profile_images/$phoneNumber',
          ),
        );
        _newUserPhoneNumber = Rx<String?>(phoneNumber);
        _newUserUsername = Rx<String?>(username);
        debug.log('Image File Successfully Captured');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
        debug.log('Image Wasn\'t Captured');
      }
    }
  }

  String trimmedImageURL() {
    String host = Converter.townOrInstitutionAsString(
      Converter.toSupportedTownOrInstitution(
        newUserArea.sectionName,
      ).townOrInstitutionName,
    ).toLowerCase();

    if (!_newUserImageURL.value!.contains('/$host') ||
        !_newUserImageURL.value!.contains('?')) {
      return _newUserImageURL.value!
          .substring(
            _newUserImageURL.value!.indexOf('/o/') + 2,
            _newUserImageURL.value!.indexOf('?'),
          )
          .replaceAll('%2F', '/')
          .replaceAll('%20', ' ')
          .replaceAll('%2B', '+');
    }
    return _newUserImageURL.value!
        .substring(
          _newUserImageURL.value!.indexOf('/$host'),
          _newUserImageURL.value!.indexOf('?'),
        )
        .replaceAll('%2F', '/')
        .replaceAll('%20', ' ')
        .replaceAll('%2B', '+');
  }

  Stream<List<my.User>> readUsers() {
    return firestore
        .collection('users')
        .where(
          'area.areaNo',
          isEqualTo: Converter.toSupportedArea(
            locateableSectionName.value!,
          ).areaNo,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            my.User user = my.User.fromJson(doc.data());
            return user;
          }).toList(),
        );
  }

  void setNewUserArea(String chosenSectionName) {
    _newUserArea = Rx<SupportedArea>(
      Converter.toSupportedArea(Converter.toSectionName(chosenSectionName)),
    );
    update();
  }

  void setSearchedSectionName(String chosenSectionName) {
    locateableSectionName = Rx<SectionName?>(
      Converter.toSectionName(chosenSectionName),
    );
    update();
  }

  Future<UserSavingStatus> saveUser() async {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user != null) {
      Get.snackbar("Saving Error", "Logout Before Registering New Users.");
      return UserSavingStatus.unathourized;
    }

    if (newUserProfileImageFile != null &&
        _newUserImageURL.value!.isNotEmpty &&
        _newUserPhoneNumber.value!.isNotEmpty &&
        _newUserUsername.value!.isNotEmpty) {
      try {
        String trimmedURL = trimmedImageURL();

        my.User user = my.User(
          userId: auth.currentUser!.uid,
          password: _newUserPassword.value,
          phoneNumber: _newUserPhoneNumber.value,
          profileImageURL: trimmedURL,
          username: _newUserUsername.value!,
          area: _newUserArea.value,
        );

        await firestore.collection('users').doc(user.userId).set(user.toJson());
        loginUserUsingObject(user);

        return UserSavingStatus.saved;
      } catch (error) {
        Get.snackbar("Saving Error", "User Couldn'\t Be Created.");
        debug.log(error.toString());

        return UserSavingStatus.alcoholCreationError;
      }
    } else {
      return UserSavingStatus.incompleteData;
    }
  }
}
