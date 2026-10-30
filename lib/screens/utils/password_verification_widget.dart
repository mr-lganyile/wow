import '/models/users/admin.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/shared_resources_controller.dart';
import '../../main.dart';

import '../../models/users/user.dart' as my;
import 'globals.dart';
import '../../models/users/abstract_user.dart';
import 'start_screen.dart';

class PasswordVerificationWidget extends StatelessWidget {
  TextEditingController passwordEditingController = TextEditingController();
  SharedResourcesController sharedResourcesController =
      SharedResourcesController.sharedResourcesController;
  AbstractUser user;
  PasswordVerificationWidget({required this.user});
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
            Get.close(2);
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    minLines: 1,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: proceedButton(context),
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
        // Disable progress bar for the previous screen (verification screen).
        if (sharedResourcesController.showPhoneVerificationProgressBar) {
          sharedResourcesController.setShowPhoneVerificationProgressBar(false);
        }

        // Enable progress bar for current screen (password screen) if it not yet enabled.
        if (!sharedResourcesController.showPasswordVerificationProgressBar) {
          sharedResourcesController.setShowPasswordVerificationProgressBar(
            true,
          );
        }

        if (user.password.compareTo(passwordEditingController.text) == 0) {
          if (user is my.User) {
            userController.loginUserUsingObject(user as my.User);
            getSnapbar('Welcome', 'You Are Currently Logged in.');
            sharedResourcesController.setShowPasswordVerificationProgressBar(
              false,
            );

            Get.to(() => StartScreen());
          } else if (user is Admin) {
            adminController.loginAdminUsingObject(user as Admin);
            getSnapbar('Welcome', 'You Are Currently Logged in.');
            sharedResourcesController.setShowPasswordVerificationProgressBar(
              false,
            );

            Get.to(() => StartScreen());
          }
        } else {
          if (sharedResourcesController.showPasswordVerificationProgressBar) {
            sharedResourcesController.setShowPasswordVerificationProgressBar(
              false,
            );
          }

          getSnapbar('Login Failed', 'Wrong Password');
        }
      },
      child: const Center(
        child: Text(
          'Login',
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
