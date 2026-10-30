import '../../models/users/user.dart' as my;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';
import '../../controllers/hosting_area_controller.dart';
import '../../main.dart';
import '../utils/globals.dart';
import '../utils/login_widget.dart';
import 'admin_screens_widget.dart';

class AdminEntranceWidget extends StatelessWidget {
  TextEditingController adminCodeEditingController = TextEditingController();
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  AdminController adminController = AdminController.adminController;

  AdminEntranceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        'Administration',
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
                  image: DecorationImage(image: AssetImage('assets/logo.png')),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Alco',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.logoColor1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  minLines: 1,
                  maxLength: 17,
                  style: TextStyle(color: MyApplication.logoColor1),
                  cursorColor: MyApplication.logoColor1,
                  controller: adminCodeEditingController,
                  decoration: InputDecoration(
                    labelText: 'Admin Code',
                    prefixIcon: Icon(
                      Icons.admin_panel_settings,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: proceedButton(),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget proceedButton() => Builder(
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: MyApplication.logoColor1,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () async {
            if (getCurrentlyLoggenInUser() is my.User) {
              getSnapbar(
                'Unauthorized',
                'Signed In Non Admin Users Not Allowed.',
              );
              return;
            }
            adminController.setSuperiorAdminEntranceCode(
              adminCodeEditingController.text,
            );
            if (!adminController.isCorrectSuperiorAdminEntrancePassword()) {
              getSnapbar('Unauthorized', 'Only Admins Are Allowed.');
            } else {
              Get.to(
                () => isLoggedInAdmin()
                    ? AdminScreensWidget()
                    : LoginWidget(forAdmin: true),
              );
            }
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
    },
  );
}
