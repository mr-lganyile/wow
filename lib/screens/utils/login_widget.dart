import '../../controllers/user_controller.dart';
import '/controllers/shared_resources_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../main.dart';
import 'dart:developer' as debug;

import 'globals.dart';
import 'verification_screen.dart';

class LoginWidget extends StatelessWidget {
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool forAdmin;

  UserController userController = UserController.userController;

  SharedResourcesController sharedResourcesController =
      SharedResourcesController.sharedResourcesController;

  LoginWidget({required this.forAdmin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: MyApplication.infoTextFontSize,
            color: MyApplication.attractiveColor1,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 20,
          color: MyApplication.logoColor2,
          onPressed: (() {
            Get.back();
          }),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(color: Colors.black),
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    minLines: 1,
                    maxLength: 10,
                    style: TextStyle(color: MyApplication.logoColor1),
                    cursorColor: MyApplication.logoColor1,
                    controller: phoneNumberEditingController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: GetBuilder<SharedResourcesController>(
                    builder: (_) {
                      return proceedButton(context);
                      /* !sharedResourcesController.showLoginProgressBar
                          ? proceedButton(context)
                          : Center(
                              child: CircularProgressIndicator(
                                color: MyApplication.logoColor2,
                              ),
                            );*/
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget proceedButton(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    decoration: BoxDecoration(
      color: MyApplication.logoColor1,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: InkWell(
      onTap: () async {
        String phoneNumber =
            '+27${phoneNumberEditingController.text.substring(1)}';

        // Enable progress bar for the current screen (login screen) if needed.
        if (!sharedResourcesController.showLoginProgressBar) {
          debug.log('The provided phone number is $phoneNumber.');
          sharedResourcesController.setShowLoginProgressBar(true);
        }
        await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            debug.log('1. About To Signed In User From LoginWidget...');
            // ANDROID ONLY!
            // Sign the user in (or link) with the auto-generated credential
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              Get.back();
              Get.snackbar('Error', 'Invalid Number Entered, Try Again.');
            } else if (e.code == 'missing-phone-number') {
              Get.back();
              Get.snackbar(
                'Error',
                'The request was triggered but no phone number string was passed to the function.',
              );
            } else if (e.code == 'missing-verification-code') {
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
          },
          codeSent: (String verificationId, int? resendToken) async {
            //  Disable progress bar for the next screen (verification screen) if needed.
            if (sharedResourcesController.showPhoneVerificationProgressBar) {
              sharedResourcesController.setShowPhoneVerificationProgressBar(
                false,
              );
            }
            debug.log('The provided phone number is $phoneNumber.');

            Get.to(
              () => VerificationScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
                forAdmin: forAdmin,
                forLogin: true,
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      },
      child: const Center(
        child: Text(
          'Proceed',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
