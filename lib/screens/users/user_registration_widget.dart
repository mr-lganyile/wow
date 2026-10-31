import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../controllers/shared_resources_controller.dart' as shared;
import '../../models/converter.dart';
import '../utils/globals.dart';
import '../utils/verification_screen.dart';
import '/models/locations/supported_area.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controllers/location_controller.dart';
import '../../main.dart';

import 'dart:developer' as debug;

import '../utils/login_widget.dart';

class UserRegistrationWidget extends StatefulWidget {
  UserRegistrationWidget();

  @override
  State createState() => UserRegistrationState();
}

class UserRegistrationState extends State<UserRegistrationWidget> {
  LocationController locationController = LocationController.locationController;
  UserController userController = UserController.userController;
  shared.SharedResourcesController sharedResourcesController =
      shared.SharedResourcesController.sharedResourcesController;

  late List<String> items;

  String countryDialCode = '+27';

  Color textColor = Colors.green;
  late DropdownButton2<String> dropDowButton;

  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  // Sydenham area is not currently added.
  Widget pickAreaName(BuildContext context) {
    dropDowButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(Icons.location_city, size: 22, color: MyApplication.logoColor1),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Pick Your Area',
              style: TextStyle(fontSize: 14, color: MyApplication.logoColor2),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: items
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.logoColor1,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      value: Converter.asString(userController.newUserArea.sectionName),
      onChanged: (String? value) {
        userController.setNewUserArea(value!);
      },
      buttonStyleData: ButtonStyleData(
        height: 60,
        // width: MediaQuery.of(context).size.width * 0.90,
        width: MediaQuery.sizeOf(context).width * 0.90,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: MyApplication.logoColor2),
          color: MyApplication.scaffoldColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: 14,
        iconEnabledColor: MyApplication.logoColor2,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        // width: MediaQuery.of(context).size.width * 0.95, causes keyboard glitches
        width: MediaQuery.sizeOf(context).width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        offset: const Offset(10, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );

    return DropdownButtonHideUnderline(child: dropDowButton);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: MyApplication.backArrowFontSize,
            color: MyApplication.backArrowColor,
            onPressed: (() {
              Get.back();
            }),
          ),
          title: Text(
            'Registration',
            style: TextStyle(
              fontSize: MyApplication.backArrowTitleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          foregroundColor: MyApplication.backArrowTitleColor,
          elevation: 0,
        ),
        backgroundColor: MyApplication.scaffoldColor,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(height: 5),

                // User Phone Number.
                IntlPhoneField(
                  controller: phoneNumberEditingController,
                  cursorColor: MyApplication.logoColor1,
                  autofocus: true,
                  showDropdownIcon: false,
                  invalidNumberMessage: '[Invalid Phone Number!]',
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: MyApplication.logoColor1,
                  ),
                  dropdownTextStyle: TextStyle(
                    fontSize: 16,
                    color: MyApplication.logoColor1,
                  ),
                  initialCountryCode: 'ZA',
                  flagsButtonPadding: const EdgeInsets.only(right: 10),
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 17),

                // Username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    maxLength: 10,
                    style: TextStyle(color: MyApplication.logoColor1),
                    cursorColor: MyApplication.logoColor1,
                    controller: usernameEditingController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: MyApplication.logoColor1,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: MyApplication.logoColor2,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: MyApplication.logoColor2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: MyApplication.logoColor2),
                      ),
                    ),
                    obscureText: false,
                  ),
                ),

                // User Area Name
                StreamBuilder<List<SupportedArea>>(
                  stream: locationController.readAllSupportedAreas(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> dbItems = [];
                      for (
                        int areaIndex = 0;
                        areaIndex < snapshot.data!.length;
                        areaIndex++
                      ) {
                        dbItems.add(snapshot.data![areaIndex].toString());
                      }

                      items = dbItems;

                      return GetBuilder<UserController>(
                        builder: (_) {
                          return pickAreaName(context);
                        },
                      );
                    } else if (snapshot.hasError) {
                      debug.log(
                        "Error Fetching Supported Areas Data - ${snapshot.error}",
                      );
                      return getCircularProgressBar();
                    } else {
                      return getCircularProgressBar();
                    }
                  },
                ),

                const SizedBox(height: 5),

                // User Image
                GetBuilder<UserController>(
                  builder: (_) {
                    return userController.newUserImageURL!.isNotEmpty
                        ? CachedNetworkImage(
                            // key: UniqueKey(),
                            fit: BoxFit.cover,
                            imageUrl: userController.newUserImageURL!,
                            fadeOutCurve: Curves.easeOutExpo,
                            imageBuilder: (c, provider) {
                              return CircleAvatar(
                                backgroundImage: provider,
                                radius:
                                    // MediaQuery.of(context).size.width * 0.15,
                                    MediaQuery.sizeOf(context).width * 0.15,
                              );
                            },
                            placeholder: (c, s) {
                              return getCircularProgressBar();
                            },
                            errorWidget: (c, s, d) {
                              return getCircularProgressBar();
                            },
                          )
                        : const SizedBox.shrink();
                  },
                ),

                // Image Picking Or Capturing
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Capture/Pick Your Face',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: MyApplication.logoColor1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              //flex: 4,
                              child: IconButton(
                                iconSize:
                                    // MediaQuery.of(context).size.width * 0.15,
                                    MediaQuery.sizeOf(context).width * 0.15,

                                icon: Icon(
                                  Icons.camera_alt,
                                  color: MyApplication.logoColor2,
                                ),
                                onPressed: () {
                                  // Every once in a white dirty profile images should be deleted from storage.
                                  if (isValidPhoneNumber(
                                    '$countryDialCode${phoneNumberEditingController.text}',
                                  )) {
                                    userController
                                        .captureUserProfileImageWithCamera(
                                          '$countryDialCode${phoneNumberEditingController.text}',
                                          usernameEditingController.text,
                                        );
                                  } else {
                                    getSnapbar(
                                      'Error',
                                      'Enter Valid Phone Number',
                                    );
                                    debug.log('Invalid Number');
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                color: Colors.white,
                                iconSize:
                                    // MediaQuery.of(context).size.width * 0.15,
                                    MediaQuery.sizeOf(context).width * 0.15,
                                icon: Icon(
                                  Icons.upload,
                                  color: MyApplication.logoColor2,
                                ),
                                onPressed: () {
                                  // Every once in a white dirty profile images should be deleted from storage.
                                  if (isValidPhoneNumber(
                                    '$countryDialCode${phoneNumberEditingController.text}',
                                  )) {
                                    userController
                                        .chooseUserProfileImageFromGallery(
                                          '$countryDialCode${phoneNumberEditingController.text}',
                                          usernameEditingController.text,
                                        );
                                  } else {
                                    getSnapbar(
                                      'Error',
                                      'Enter Valid Phone Number',
                                    );
                                    debug.log('Invalid Number');
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    maxLength: 20,
                    style: TextStyle(color: MyApplication.logoColor1),
                    cursorColor: MyApplication.logoColor1,
                    controller: passwordEditingController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: MyApplication.logoColor1,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: MyApplication.logoColor2,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: MyApplication.logoColor2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: MyApplication.logoColor2),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 5),

                GetBuilder<shared.SharedResourcesController>(
                  builder: (_) {
                    return /*sharedResourcesController.showSigninProgressBar
                        ? Center(
                            child: CircularProgressIndicator(
                              color: MyApplication.logoColor2,
                            ),
                          )
                        : */ Column(
                      children: [
                        // Sign Up User
                        Container(
                          // width: MediaQuery.of(context).size.width, causes keyboard glitches
                          width: MediaQuery.sizeOf(context).width,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: MyApplication.logoColor1,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              debug.log('clicked...');
                              if (getCurrentlyLoggenInUser() != null) {
                                Get.snackbar(
                                  "Signing Error",
                                  "Logout Before Registering New Users.",
                                );
                                return;
                              }

                              debug.log(
                                'User Validation From UserRegistrationScreen 1',
                              );

                              if (phoneNumberEditingController.text.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Ensure A Phone Number Is Entered.",
                                );
                              } else if (phoneNumberEditingController
                                      .text
                                      .length !=
                                  9) {
                                Get.snackbar(
                                  "Error",
                                  "Ensure A 10 Digit Phone Number Is Entered.",
                                );
                              } else if (usernameEditingController
                                  .text
                                  .isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Ensure A Username Is Entered.",
                                );
                              } else if (passwordEditingController
                                  .text
                                  .isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Ensure A Password Is Entered.",
                                );
                              } else if (userController
                                  .newUserImageURL!
                                  .isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Ensure Your Image Is Picked/Captured.",
                                );
                              }
                              // Create User Now
                              else {
                                userController.setNewUserUsername(
                                  usernameEditingController.text,
                                );

                                userController.setNewUserPassword(
                                  passwordEditingController.text,
                                );

                                sharedResourcesController
                                    .setShowSigninProgressBar(true);
                                debug.log(
                                  'User Validated From UserRegistrationScreen 2',
                                );

                                await auth.verifyPhoneNumber(
                                  phoneNumber:
                                      '+27${phoneNumberEditingController.text}',
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) async {
                                        debug.log('PhoneAuthCredential...');
                                        /*
                                    debug.log(
                                        '1. About To Signed In User From UserRegistrationScreen...');
                                    // ANDROID ONLY!
                                    // Sign the user in (or link) with the auto-generated credential
                                    await auth.signInWithCredential(credential);

                                    debug.log(
                                        '1. Successfully Signed In User From UserRegistrationScreen...');
                                    Future<UserSavingStatus> savingStatus =
                                        userController.saveUser(
                                            auth.currentUser!.uid);

                                    savingStatus.then((value) {
                                      if (value ==
                                          UserSavingStatus.unathourized) {
                                        debug.log(
                                            'UserSavingStatus.unathourized From UserRegistrationScreen...');
                                      } else if (value ==
                                          UserSavingStatus
                                              .adminAlreadyExist) {
                                        debug.log(
                                            'UserSavingStatus.adminAlreadyExist From UserRegistrationScreen...');
                                      } else if (value ==
                                          UserSavingStatus.loginRequired) {
                                        debug.log(
                                            'UserSavingStatus.loginRequired From UserRegistrationScreen...');
                                      } else if (value ==
                                          UserSavingStatus
                                              .incompleteData) {
                                        debug.log(
                                            'UserSavingStatus.incompleteData From UserRegistrationScreen...');
                                      } else {
                                        debug.log(
                                            '2. Successfully Saved User From UserRegistrationScreen...');
                                      }
                                    });
                                    */
                                      },
                                  verificationFailed: (FirebaseAuthException e) {
                                    if (e.code == 'invalid-phone-number') {
                                      Get.back();
                                      Get.snackbar(
                                        'Error',
                                        'Invalid Number Entered, Try Again.',
                                      );
                                    } else if (e.code ==
                                        'missing-phone-number') {
                                      Get.back();
                                      Get.snackbar(
                                        'Error',
                                        'The request was triggered but no phone number string was passed to the function.',
                                      );
                                    } else if (e.code ==
                                        'missing-verification-code') {
                                      Get.back();
                                      Get.snackbar(
                                        'Error',
                                        'The PhoneAuthCredential was created with an empty SMS code.',
                                      );
                                    } else if (e.code == 'quota-exceeded') {
                                      Get.back();
                                      Get.snackbar(
                                        'Error',
                                        'The SMS quota for your project or IP address has been temporarily exceeded',
                                      );
                                    } else if (e.code == 'too-many-requests') {
                                      Get.back();
                                      Get.snackbar(
                                        'Error',
                                        'Too many requests have been made from this phone number',
                                      );
                                    } else {
                                      Get.back();
                                      Get.snackbar('Error', 'Try Again.');
                                    }

                                    // Handle other errors
                                  },
                                  codeSent:
                                      (
                                        String verificationId,
                                        int? resendToken,
                                      ) async {
                                        debug.log(
                                          '....About To VerificationScreen',
                                        );
                                        Get.to(
                                          () => VerificationScreen(
                                            phoneNumber:
                                                '$countryDialCode${phoneNumberEditingController.text}',
                                            verificationId: verificationId,
                                            forAdmin: false,
                                            forLogin: false,
                                          ),
                                        );
                                      },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                color: MyApplication.logoColor1,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Send User To Login Screen.
                                userController
                                    .logoutUser(); // Logout currently logged in user.
                                Get.to(() => LoginWidget(forAdmin: false));
                              },
                              child: Text(
                                " Login",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyApplication.logoColor2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
