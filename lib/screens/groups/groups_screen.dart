import '/models/users/admin.dart';

import '/models/users/user.dart' as my;

import '../../controllers/group_controller.dart';
import '/models/converter.dart';
import '../../models/users/abstract_user.dart';
import '../utils/globals.dart';
import '/controllers/competition_controller.dart';

import '../../models/users/group.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'single_group_widget.dart';
import 'dart:developer' as debug;

// Branch : group_resources_crud ->  view_groups
class GroupsScreen extends StatefulWidget {
  static const String id = "GroupsScreen";
  const GroupsScreen({super.key});

  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  CompetitionController competitionController =
      CompetitionController.competitionController;
  GroupController groupController = GroupController.instance;
  late Stream<List<Group>> groupsStream;
  late List<Group> allGroups;

  @override
  void initState() {
    super.initState();

    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      groupsStream = groupController.readAreaGroups("7"); // durban central
    } else if (user is Admin) {
      groupsStream = groupController.readAreaGroups(
        Converter.townOrInstitutionAsString(user.townOrInstitution),
      );
    } else {
      groupsStream = groupController.readAreaGroups(
        (user as my.User).area.townOrInstitutionFK,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 300,
    decoration: BoxDecoration(
      color: MyApplication.scaffoldColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: StreamBuilder<List<Group>>(
      stream: groupsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          allGroups = snapshot.data!;
          allGroups.sort();

          return ListView.builder(
            itemCount: allGroups.length,
            itemBuilder: ((context, index) {
              return SingleGroupWidget(competitorsGroup: allGroups[index]);
            }),
          );
        } else if (snapshot.hasError) {
          debug.log("Error Fetching Data D- ${snapshot.error}");
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      },
    ),
  );
}
