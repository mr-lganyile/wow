import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controllers/group_controller.dart';
import '../../controllers/shared_resources_controller.dart';
import '../../main.dart';

import 'package:flutter/material.dart';

import '../utils/globals.dart';

class GroupVerificationWidget extends StatefulWidget {
  String verificationId;

  GroupVerificationWidget({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<GroupVerificationWidget> createState() =>
      _GroupVerificationWidgetState();
}

class _GroupVerificationWidgetState extends State<GroupVerificationWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  GroupController groupController = GroupController.instance;
  SharedResourcesController sharedResourcesController =
      SharedResourcesController.sharedResourcesController;

  Color snackBarBackgroundColor = Colors.white;
  Duration snackBarDuration = const Duration(seconds: 5);
  Color snackBarColorText = Colors.white;
  Color snackBarBorderColor = Colors.white;

  void verify() async {
    sharedResourcesController.setShowProgressBar(true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: otpController.text);
      final auth = FirebaseAuth.instance;
      await auth.signInWithCredential(credential);

      auth.currentUser!.getIdToken(true).then((token) async {
        if (!sharedResourcesController.isLeaderValidated) {
          sharedResourcesController.setIsLeaderValidated(true);
          Get.back();
        }
      }).catchError((onError) {});
    } catch (error) {
      getSnapbar(
          // backgroundColor: snackBarBackgroundColor,
          // duration: snackBarDuration,
          // colorText: snackBarColorText,
          // borderColor: snackBarBorderColor,
          'Error',
          'Wrong Verification Code.');
    } finally {
      sharedResourcesController.setShowProgressBar(false);
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
                  const SizedBox(
                    height: 20,
                  ),
                  _subHeadingText(),
                  const SizedBox(
                    height: 20,
                  ),
                  _numberText()
                ],
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
                    prefixIcon:
                        Icon(Icons.numbers, color: MyApplication.logoColor1),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: MyApplication.logoColor2,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: MyApplication.logoColor2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: MyApplication.logoColor2,
                      ),
                    ),
                  ),
                  obscureText: false,
                ),
              ),
              sharedResourcesController.showProgressBar
                  ? getCircularProgressBar()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: MyApplication.logoColor1,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: InkWell(
                        onTap: () async {
                          verify();
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
                    )
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
            color: MyApplication.attractiveColor1),
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
        groupController.leaderPhoneNumber,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: MyApplication.logoColor1),
      );
}
