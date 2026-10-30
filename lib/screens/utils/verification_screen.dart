import '../../controllers/user_controller.dart';
import '../../controllers/shared_resources_controller.dart';
import '../users/user_registration_widget.dart';
import '/screens/utils/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../main.dart';

import 'package:flutter/material.dart';

import 'dart:developer' as debug;

import 'globals.dart';
import 'password_verification_widget.dart';

// Branch : group_resources_crud ->  create_group_resources_front_end
class VerificationScreen extends StatefulWidget {
  String phoneNumber;
  String verificationId;
  bool forAdmin;
  bool forLogin;

  VerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
    required this.forAdmin,
    required this.forLogin,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  UserController userController = UserController.userController;

  SharedResourcesController sharedResourcesController =
      SharedResourcesController.sharedResourcesController;

  Color snackBarBackgroundColor = Colors.white;
  Duration snackBarDuration = const Duration(seconds: 5);
  Color snackBarColorText = Colors.white;
  Color snackBarBorderColor = Colors.white;

  void verifySignin() async {
    try {
      // Disable progress bar for the previous screen (Admin/Alco Reg screen) if needed.
      if (sharedResourcesController.showSigninProgressBar) {
        sharedResourcesController.setShowSigninProgressBar(false);
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );
      final auth = FirebaseAuth.instance;
      await auth.signInWithCredential(credential);

      debug.log('Credentials Verified Successfully');

      auth.currentUser!
          .getIdToken(true)
          .then((token) async {
            /*// Send token to backend
        HttpsCallable callableFuntion =
            FirebaseFunctions.instance.httpsCallable(
          'setCurrentUID',
          options: HttpsCallableOptions(
            timeout: const Duration(seconds: 1),
          ),
        );

        Map<String, dynamic> data = {
          'token': token,
          'userId': auth.currentUser!.uid,
        };

        bool hasSignedIn = (await callableFuntion.call(data)) as bool; */

            Future<UserSavingStatus> alcoholSavingStatus = userController
                .saveUser(/*auth.currentUser!.uid*/);
            debug.log('forAdmin == false');

            alcoholSavingStatus.then((value) {
              if (value == UserSavingStatus.unathourized) {
                debug.log(
                  'UserSavingStatus.unathourized From VerificationScreen...',
                );
                getSnapbar(
                  // backgroundColor: snackBarBackgroundColor,
                  // duration: snackBarDuration,
                  // colorText: snackBarColorText,
                  // borderColor: snackBarBorderColor,
                  'Error',
                  'You Are Not Authorized To Register A New User.',
                );
                Get.close(2);
              } else if (value == UserSavingStatus.alcoholCreationError) {
                debug.log(
                  'UserSavingStatus.alcoholCreationError From VerificationScreen...',
                );
                getSnapbar("Saving Error", "User Couldn'\t Be Created.");
                Get.close(2);
              } else if (value == UserSavingStatus.adminAlreadyExist) {
                debug.log(
                  'UserSavingStatus.adminAlreadyExist From VerificationScreen...',
                );
                getSnapbar(
                  // backgroundColor: snackBarBackgroundColor,
                  // duration: snackBarDuration,
                  // colorText: snackBarColorText,
                  // borderColor: snackBarBorderColor,
                  'Error',
                  'User Already Exist.',
                );
                Get.back();
              } else if (value == UserSavingStatus.loginRequired) {
                debug.log(
                  'UserSavingStatus.loginRequired From VerificationScreen...',
                );
                getSnapbar(
                  // backgroundColor: snackBarBackgroundColor,
                  // duration: snackBarDuration,
                  // colorText: snackBarColorText,
                  // borderColor: snackBarBorderColor,
                  'Error',
                  'Login Required.',
                );
                Get.to(() => LoginWidget(forAdmin: widget.forAdmin));
              } else if (value == UserSavingStatus.incompleteData) {
                debug.log(
                  'UserSavingStatus.incompleteData From VerificationScreen...',
                );
                getSnapbar(
                  // backgroundColor: snackBarBackgroundColor,
                  // duration: snackBarDuration,
                  // colorText: snackBarColorText,
                  // borderColor: snackBarBorderColor,
                  'Error',
                  'Incomplete Info.',
                );
                Get.back();
              } else {
                Get.close(2);
              }
            });
          })
          .catchError((onError) {});
    } catch (error) {
      debug.log('Credentials Verified Unsuccessfully');
      getSnapbar(
        // backgroundColor: snackBarBackgroundColor,
        // duration: snackBarDuration,
        // colorText: snackBarColorText,
        // borderColor: snackBarBorderColor,
        'Error',
        'Wrong Verification Code.',
      );
      debug.log('$error');
    }
  }

  void verifyLogin() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );
      final auth = FirebaseAuth.instance;
      await auth.signInWithCredential(credential);

      auth.currentUser!
          .getIdToken(true)
          .then((token) async {
            await userController.findUser(auth.currentUser!.uid).then((user) {
              if (user == null) {
                getSnapbar('Registration Required', 'User Do Not Exist.');
                Get.to(() => UserRegistrationWidget());
              } else {
                sharedResourcesController.setShowPhoneVerificationProgressBar(
                  false,
                );
                Get.to(() => PasswordVerificationWidget(user: user));
              }
            });
          })
          .catchError((onError) {});
    } catch (error) {
      getSnapbar(
        // backgroundColor: snackBarBackgroundColor,
        // duration: snackBarDuration,
        // colorText: snackBarColorText,
        // borderColor: snackBarBorderColor,
        'Error',
        'Wrong Verification Code.',
      );
      debug.log('Wrong Verification Code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _headingText(),
                  const SizedBox(height: 20),
                  _subHeadingText(),
                  const SizedBox(height: 20),
                  _numberText(),
                ],
              ),
              GetBuilder<SharedResourcesController>(
                builder: (_) {
                  return sharedResourcesController
                          .showPhoneVerificationProgressBar
                      ? IconButton(
                          icon: const Icon(Icons.refresh),
                          iconSize: blueIconsSize,
                          color: MyApplication.backArrowColor,
                          onPressed: (() {
                            sharedResourcesController
                                .setShowPhoneVerificationProgressBar(false);
                          }),
                        )
                      : const SizedBox.shrink();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  style: TextStyle(color: MyApplication.logoColor1),
                  cursorColor: MyApplication.logoColor1,
                  controller: otpController,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    prefixIcon: Icon(
                      Icons.numbers,
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
              GetBuilder<SharedResourcesController>(
                builder: (_) {
                  return /*sharedResourcesController
                          .showPhoneVerificationProgressBar
                      ? Center(
                          child: CircularProgressIndicator(
                            color: MyApplication.logoColor2,
                          ),
                        )
                      : */ Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: MyApplication.logoColor1,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: InkWell(
                      onTap: () async {
                        // Disable progress bar for the previous screen (login screen) if needed.
                        if (sharedResourcesController.showLoginProgressBar) {
                          sharedResourcesController.setShowLoginProgressBar(
                            false,
                          );
                        }

                        // Disable progress bar for the previous screen (signin screen) if needed.
                        if (sharedResourcesController.showSigninProgressBar) {
                          sharedResourcesController.setShowSigninProgressBar(
                            false,
                          );
                        }

                        // Enable progress bar for the current scree (verification screen) if needed.
                        if (!sharedResourcesController
                            .showPhoneVerificationProgressBar) {
                          sharedResourcesController
                              .setShowPhoneVerificationProgressBar(true);
                        }

                        widget.forLogin ? verifyLogin() : verifySignin();
                      },
                      child: const Center(
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headingText() => Text(
    'Verification',
    style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 25,
      color: MyApplication.attractiveColor1,
    ),
  );

  Widget _subHeadingText() => const Text(
    'Enter the code sent to te number.',
    style: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 15,
      color: Colors.white38,
    ),
  );

  Widget _numberText() => Text(
    widget.phoneNumber,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: MyApplication.logoColor1,
    ),
  );
}
