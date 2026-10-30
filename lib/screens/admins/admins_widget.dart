import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../controllers/admin_controller.dart';
import '../../main.dart';
import '../../models/converter.dart';
import '../../models/users/admin.dart';
import '../../models/users/abstract_user.dart';
import '../utils/globals.dart';
import 'dart:developer' as debug;

class AdminsWidget extends StatefulWidget {
  AdminsWidget();

  @override
  State<StatefulWidget> createState() => AdminsWidgetState();
}

class AdminsWidgetState extends State<AdminsWidget> {
  late AdminController adminController;
  late Stream<List<Admin>> adminsStream;

  @override
  void initState() {
    super.initState();
    adminController = AdminController.adminController;
    adminsStream = adminController.readAdmins();
  }

  Widget adminInfo(Admin admin) => Container(
    margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    child: InkWell(
      onTap: (() {
        AbstractUser? user = getCurrentlyLoggenInUser();

        if (user is Admin) {
          if (admin.isSuperior) {
            getSnapbar('Action Prohibited', 'Cannot Block A Superior Admin');
            return;
          }

          if (user.isBlocked) {
            getSnapbar('Action Prohibited', 'You Are Blocked');
            return;
          }

          if (!user.isSuperior) {
            getSnapbar(
              'Action Prohibited',
              'Only Superior Admin May Block Other Admins.',
            );
            return;
          }
          setState(() {
            bool newValue = !admin.isBlocked;

            adminController.blockOrUnblockAdmin(admin.phoneNumber, newValue);
          });
        } else {
          getSnapbar('Unauthorized User', 'Update Failed');
        }
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: findFullURL(admin.profileImageURL),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  /*return CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.09,
                          backgroundColor: backgroundResourcesColor,
                          backgroundImage:
                              NetworkImage(snapshot.data as String),
                        ); */
                  return CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: snapshot.data as String,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.09,
                        backgroundColor: backgroundResourcesColor,
                        backgroundImage: provider,
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
                        '@${Converter.townOrInstitutionAsString(admin.townOrInstitution)}',
                        style: TextStyle(
                          fontSize: listTileText1FontSize,
                          color: MyApplication.logoColor1,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: !admin.isBlocked
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ],
                  ),
                  Text(
                    'Contact No ${admin.phoneNumber}',
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
                    'Joined On ${admin.joinedOn.toString().substring(0, 10)}',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: MyApplication.attractiveColor1,
                      fontSize: listTileText2FontSize,
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

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 5),
      Expanded(
        child: StreamBuilder<List<Admin>>(
          stream: adminsStream,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              List<Admin> admins = snapshot.data as List<Admin>;
              return ListView.builder(
                itemCount: admins.length,
                itemBuilder: ((context, index) {
                  return adminInfo(admins[index]);
                }),
              );
            } else if (snapshot.hasError) {
              debug.log('Error Groups Data');
              return getCircularProgressBar();
            } else {
              return getCircularProgressBar();
            }
          }),
        ),
      ),
    ],
  );
}
