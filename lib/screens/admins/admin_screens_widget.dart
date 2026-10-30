import '/screens/utils/globals.dart';
import '/screens/utils/start_screen.dart';

import '../../controllers/group_controller.dart';
import '../../models/users/admin.dart';
import '../hosting area/hosted_draw_registration_widget.dart';
import 'admin_registration_widget.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../main.dart';

import 'admins_widget.dart';
import 'notification_creation_widget.dart';
import 'recruitment_widget.dart';
import 'vouchers_widget.dart';

class AdminScreensWidget extends StatefulWidget {
  AdminScreensWidget({
    super.key,
  });

  @override
  _AdminScreensWidgetState createState() => _AdminScreensWidgetState();
}

class _AdminScreensWidgetState extends State<AdminScreensWidget>
    with SingleTickerProviderStateMixin {
  late GroupController groupController;
  int currentIndex = 0;
  double listTilesFontSize = 15;
  double listTilesIconSize = 30;
  bool groupsDeactivated = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: getTitles().length,
      vsync: this,
    );
    groupController = GroupController.instance;
  }

  List<String> getTitles() {
    return isSuperior()
        ? [
            'Admins',
            'Recruition',
            'Draws',
            'Notification',
            'Activation',
            'Vouchers'
          ]
        : [
            'Admins',
            'Draws',
            'Notification',
            'Activation',
          ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateCurrentIndex(int index) {
    setState(() => currentIndex = index);
  }

  void refresh() async {
    groupsDeactivated = !groupsDeactivated;
    await groupController.activateOrDeactivateAllGroups(groupsDeactivated);
    setState(() {});
  }

  isSuperior() {
    Admin? admin = adminController.currentlyLoggedInAdmin;
    if (admin != null) {
      return admin.isSuperior;
    }

    return false;
  }

  List<Widget> getTabsList() {
    return isSuperior()
        ? [
            Tab(
              icon: Icon(
                Icons.group,
                color: MyApplication.attractiveColor1,
              ),
              text: 'Admins',
            ),
            Tab(
              icon: Icon(Icons.admin_panel_settings,
                  color: MyApplication.attractiveColor1),
              text: 'Recruit',
            ),
            Tab(
              icon: Icon(Icons.draw, color: MyApplication.attractiveColor1),
              text: 'Draws',
            ),
            Tab(
              icon: Icon(Icons.notifications,
                  color: MyApplication.attractiveColor1),
              text: 'Notify',
            ),
            Tab(
              icon: Icon(Icons.card_membership,
                  color: MyApplication.attractiveColor1),
              text: 'Activation',
            ),
            Tab(
              icon: Icon(Icons.numbers, color: MyApplication.attractiveColor1),
              text: 'Vouchers',
            ),
          ]
        : [
            Tab(
              icon: Icon(
                Icons.group,
                color: MyApplication.attractiveColor1,
              ),
              text: 'Admins',
            ),
            Tab(
              icon: Icon(Icons.draw, color: MyApplication.attractiveColor1),
              text: 'Draws',
            ),
            Tab(
              icon: Icon(Icons.notifications,
                  color: MyApplication.attractiveColor1),
              text: 'Notify',
            ),
            Tab(
              icon: Icon(Icons.card_membership,
                  color: MyApplication.attractiveColor1),
              text: 'Activation',
            ),
          ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: MyApplication.scaffoldColor,
        appBar: AppBar(
          backgroundColor: MyApplication.scaffoldColor,
          leading: IconButton(
            icon: const Icon(Icons.home),
            iconSize: blueIconsSize,
            color: MyApplication.backArrowColor,
            onPressed: (() => Get.to(StartScreen())),
          ),
          title: Text(
            getTitles()[currentIndex],
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.attractiveColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            isSuperior()
                ? IconButton(
                    icon: const Icon(Icons.refresh),
                    iconSize: blueIconsSize,
                    color: MyApplication.backArrowColor,
                    onPressed: (() {
                      refresh();
                    }),
                  )
                : const SizedBox.shrink(),
            IconButton(
                icon: const Icon(Icons.logout),
                iconSize: blueIconsSize,
                color: MyApplication.backArrowColor,
                onPressed: (() {
                  adminController.logoutAdmin();
                  Get.to(StartScreen());
                })),
          ],
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            onTap: updateCurrentIndex,
            labelColor: MyApplication.logoColor1,
            controller: _tabController,
            indicatorColor: MyApplication.logoColor2,
            indicatorWeight: 5,
            //dividerHeight: 0,
            indicatorPadding: const EdgeInsets.only(bottom: 8),
            tabs: getTabsList(),
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: MyApplication.scaffoldColor,
            ),
            child: TabBarView(
                controller: _tabController, children: getTabsWidgets()),
          ),
        ),
      );

  List<Widget> getTabsWidgets() {
    return isSuperior()
        ? [
            AdminsWidget(),
            AdminRegistrationWidget(),
            const HostedDrawRegistrationWidget(),
            NotificationCreationWidget(),
            RecruitmentWidget(),
            VouchersWidget(),
          ]
        : [
            AdminsWidget(),
            const HostedDrawRegistrationWidget(),
            NotificationCreationWidget(),
            RecruitmentWidget(),
          ];
  }
}
