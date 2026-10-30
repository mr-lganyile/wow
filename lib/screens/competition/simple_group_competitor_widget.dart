import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utils/globals.dart';
import '/main.dart';
import 'package:flutter/material.dart';

import '../../models/converter.dart';
import '../../models/users/group.dart';
import 'dart:developer' as debug;

class SimpleGroupCompetitorWidget extends StatelessWidget {
  Group group;
  late List<Reference> groupMembersImageReferences;

  SimpleGroupCompetitorWidget({required this.group});

  String getAreaName() {
    String sectionName = Converter.asString(group.groupArea.sectionName);
    String areaName = sectionName.substring(0, sectionName.indexOf('-'));
    debug.log('Group Area Name : $areaName');

    return areaName;
  }

  Widget createGroupParticipant(BuildContext context, int memberIndex) {
    return FutureBuilder(
      future: groupMembersImageReferences[memberIndex].getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
            /*child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  backgroundImage: NetworkImage(snapshot.data as String),
                ),
              ), */
            child: CachedNetworkImage(
              key: UniqueKey(),
              fit: BoxFit.cover,
              imageUrl: snapshot.data as String,
              fadeOutCurve: Curves.easeOutExpo,
              imageBuilder: (c, provider) {
                return Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 8,
                    backgroundImage: provider,
                  ),
                );
              },
              placeholder: (c, s) {
                return getCircularProgressBar();
              },
              errorWidget: (c, s, d) {
                return getCircularProgressBar();
              },
            ),
          );
        } else if (snapshot.hasError) {
          debug.log("Error Fetching Group Members Data - ${snapshot.error}");
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      },
    );
  }

  Widget createGroupMembers(BuildContext context) {
    Column column;
    Row row;

    List<Widget> rowChildren;
    List<Widget> columnChildren;

    if (groupMembersImageReferences.length <= 3) {
      rowChildren = [];
      for (int i = 0; i < groupMembersImageReferences.length; i++) {
        rowChildren.add(createGroupParticipant(context, i));
      }
      row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowChildren,
      );
      return row;
    } else {
      columnChildren = [];
      rowChildren = [];
      for (int i = 0; i < 3; i++) {
        rowChildren.add(createGroupParticipant(context, i));
      }
      row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowChildren,
      );
      columnChildren.add(row);

      rowChildren = [];
      for (int i = 3; i < groupMembersImageReferences.length; i++) {
        rowChildren.add(createGroupParticipant(context, i));
      }
      row = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowChildren,
      );
      columnChildren.add(row);
      column = Column(children: columnChildren);
      return column;
    }
  }

  Future<ListResult> findGroupMembersImageURLs() async {
    String hostName = Converter.townOrInstitutionAsString(
      group.groupTownOrInstitution.townOrInstitutionName,
    ).toLowerCase();

    if (hostName.contains('howard college ukzn') &&
        'howard college ukzn'.contains(hostName)) {
      hostName = 'ukzn'; // Supposed to be ukzn-howard
    } else if (hostName.contains('mangosuthu (mut)') &&
        'mangosuthu (mut)'.contains(hostName)) {
      hostName = 'mut';
    }
    debug.log('$hostName/group_members/${group.groupId}/profile_images');

    return reference
        .child('$hostName/group_members/${group.groupId}/profile_images')
        .listAll();
  }

  // Members Of A Group
  Widget competitors() => FutureBuilder(
    future: findGroupMembersImageURLs(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        ListResult allDownloadURLs = snapshot.data!;

        /*if (allDownloadURLs.items.length > 12) {
                    List<Reference> falseImagesReferences = [];

                    for (int index = 0;
                        index < wonGroup.groupMembers.length;
                        index++) {
                      falseImagesReferences.add(allDownloadURLs.items[index]);
                    }
                    groupMembersImageReferences = falseImagesReferences;
                  } else {
                    groupMembersImageReferences = allDownloadURLs.items;
                  }*/

        groupMembersImageReferences = allDownloadURLs.items;

        return createGroupMembers(context);
      } else if (snapshot.hasError) {
        debug.log("Error Fetching Group Members Data - ${snapshot.error}");
        return getCircularProgressBar();
      } else {
        return getCircularProgressBar();
      }
    },
  );

  Future<String> findGroupCreatorImageURL() async {
    return await reference.child(group.groupCreatorImageURL).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
    child: Center(
      child: Column(
        children: [
          /*
          FutureBuilder(
            future: findGroupCreatorImageURL(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as String;

                return CachedNetworkImage(
                  key: UniqueKey(),
                  fit: BoxFit.cover,
                  imageUrl: data,
                  fadeOutCurve: Curves.easeOutExpo,
                  imageBuilder: (c, provider) {
                    return CircleAvatar(
                      backgroundColor: backgroundResourcesColor,
                      radius: 40,
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
                debug.log(
                  "Error Fetching Group Creator Data - ${snapshot.error}",
                );
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            },
          ),

          const SizedBox(height: 10), */
          !Converter.isInstitution(group.groupArea.sectionName)
              ? const SizedBox.shrink()
              : Text(
                  group.groupName,
                  style: TextStyle(
                    fontSize: 20,
                    color: MyApplication.logoColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          Text(
            group.groupSpecificArea!,
            style: TextStyle(
              fontSize: 20,
              color: MyApplication.logoColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Converter.isInstitution(group.groupArea.sectionName)
              ? const SizedBox.shrink()
              : Text(
                  Converter.isInstitution(group.groupArea.sectionName)
                      ? group.groupSpecificArea!
                      : getAreaName(),
                  style: TextStyle(
                    fontSize: 20,
                    color: MyApplication.logoColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          // competitors(),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}
