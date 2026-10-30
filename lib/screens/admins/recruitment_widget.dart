import 'package:flutter/material.dart';

import '../../controllers/admin_controller.dart';
import '../../controllers/group_controller.dart';
import '../../main.dart';
import '../../models/competitions/money_bag.dart';
import '../../models/users/group.dart';
import '../utils/globals.dart';
import 'dart:developer' as debug;

import 'recruitment_helper_widget.dart';

class RecruitmentWidget extends StatefulWidget {
  RecruitmentWidget();

  @override
  State<StatefulWidget> createState() => RecruitmentWidgetState();
}

class RecruitmentWidgetState extends State<RecruitmentWidget> {
  late GroupController groupController;
  late AdminController adminController;

  @override
  void initState() {
    super.initState();
    groupController = GroupController.instance;
    adminController = AdminController.adminController;
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: StreamBuilder(
              stream: adminController.retrieveMoneyBag(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return getCircularProgressBar();
                  }

                  MoneyBag moneyBag = MoneyBag.fromJson(snapshot.data);

                  if (moneyBag.hasMoneyCollectorSubmitted) {
                    return getCircularProgressBar();
                  }

                  return ListView.builder(
                      itemCount: moneyBag.relationships.length,
                      itemBuilder: ((context, index) {
                        List<MapEntry<String, String>> entries =
                            moneyBag.relationships.entries.toList();
                        entries.sort(((a, b) => a.key.compareTo(b.key)));

                        return FutureBuilder(
                            future: groupController.readSingleGroup(
                                entries[index].key.split(' ')[0]),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Group group = Group.fromJson(snapshot.data);
                                return RecruitmentHelperWidget(
                                  group: group,
                                  activationRequestStateColor:
                                      entries[index].value,
                                );
                              } else if (snapshot.hasError) {
                                debug.log(
                                    'Error Loading Group Data: ${snapshot.error}');
                                return getCircularProgressBar();
                              } else {
                                return getCircularProgressBar();
                              }
                            });
                      }));
                } else if (snapshot.hasError) {
                  debug.log('Error Money Bag Data ${snapshot.error}');
                  return getCircularProgressBar();
                } else {
                  return getCircularProgressBar();
                }
              })),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: confirmButton(),
        ),
      ]);

  Widget confirmButton() => Builder(builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              color: MyApplication.logoColor1,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              )),
          child: InkWell(
            onTap: () async {
              adminController.submitMoneyBag();
            },
            child: const Center(
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      });
}
