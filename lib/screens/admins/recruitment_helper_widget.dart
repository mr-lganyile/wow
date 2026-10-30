import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';
import '../../controllers/group_controller.dart';
import '../../main.dart';
import '../../models/converter.dart';
import '../../models/users/admin.dart';
import '../../models/users/group.dart';
import '../../models/users/abstract_user.dart';
import '../utils/globals.dart';

import 'dart:developer' as debug;

class RecruitmentHelperWidget extends StatelessWidget {
  Group group;
  String activationRequestStateColor;

  late GroupController groupController = GroupController.instance;
  late AdminController adminController = AdminController.adminController;

  RecruitmentHelperWidget({
    required this.group,
    required this.activationRequestStateColor,
  });

  bool? hasConformedActivationRequest() {
    Color color = toColor();
    if (color == Colors.grey) {
      return false;
    } else if (color == Colors.yellow) {
      return null;
    } else {
      return true;
    }
  }

  Color toColor() {
    if (activationRequestStateColor.contains("green")) {
      return Colors.green;
    } else if (activationRequestStateColor.contains("grey")) {
      return Colors.grey;
    } else {
      return Colors.yellow;
    }
  }

  Widget groupInfo() => GetBuilder<AdminController>(
    builder: (_) {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: InkWell(
          onTap: (() {
            AbstractUser? user = getCurrentlyLoggenInUser();

            if (user is Admin) {
              if (!(user.adminType == AdminType.moneyCollector ||
                  user.adminType ==
                      AdminType.groupRegisteryAndmoneyCollector)) {
                getSnapbar(
                  'Update Failed',
                  'Group Registery Admins Are Not Allowed.',
                );
                return;
              }

              if (activationRequestStateColor.contains("grey")) {
                debug.log('Grey Clicked');
                adminController.updateActivationRequestColorState(
                  group.groupCreatorPhoneNumber,
                  group.activationRequest!.activationRequestId,
                  "green",
                );
              } else if (activationRequestStateColor.contains("yellow")) {
                debug.log('Yellow Clicked');
                adminController.updateActivationRequestColorState(
                  group.groupCreatorPhoneNumber,
                  group.activationRequest!.activationRequestId,
                  "green",
                );
              } else if (activationRequestStateColor.contains("green")) {
                debug.log('Green Clicked');
                adminController.updateActivationRequestColorState(
                  group.groupCreatorPhoneNumber,
                  group.activationRequest!.activationRequestId,
                  "grey",
                );
              }

              adminController.saveRecruitmentHistory(
                group.groupCreatorPhoneNumber,
                hasConformedActivationRequest(),
              );
            } else {
              getSnapbar(
                'Update Failed',
                'Make sure you are logged in as an admin.',
              );
            }
          }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Money Collector's Profile Image.
              Expanded(
                child: FutureBuilder(
                  future: findFullURL(group.groupCreatorImageURL),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return CachedNetworkImage(
                        key: UniqueKey(),
                        fit: BoxFit.cover,
                        imageUrl: snapshot.data as String,
                        fadeOutCurve: Curves.easeOutExpo,
                        imageBuilder: (c, provider) {
                          return CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.09,
                            backgroundColor: backgroundResourcesColor,
                            backgroundImage: NetworkImage(
                              snapshot.data as String,
                            ),
                          );
                        },
                        placeholder: (c, s) {
                          return getCircularProgressBar();
                        },
                        errorWidget: (c, s, d) {
                          return getCircularProgressBar();
                        },
                      );
                    } else if (snapshot.hasError) {
                      return getCircularProgressBar();
                    } else {
                      return getCircularProgressBar();
                    }
                  }),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${group.groupName} @${group.groupSpecificArea}',
                            style: TextStyle(
                              fontSize: listTileText1FontSize,
                              color: MyApplication.logoColor1,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CircleAvatar(radius: 7, backgroundColor: toColor()),
                        ],
                      ),
                      Text(
                        '${group.activationRequest!.voucher} [${Converter.toVoucherAsString(group.activationRequest!.voucherType)}]',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: MyApplication.logoColor2,
                          fontSize: listTileText2FontSize,
                          fontWeight: FontWeight.w600,
                          // overflow: TextOverflow.ellipsis
                        ),
                      ),
                      Text(
                        Converter.asString(group.groupArea.sectionName),
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: MyApplication.attractiveColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) => groupInfo();
}
