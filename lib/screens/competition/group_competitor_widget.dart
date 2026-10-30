import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';

import '../../models/converter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../models/users/group.dart';
import 'dart:developer' as debug;

import '../utils/globals.dart';

// Branch : competition_resources_crud ->  view_competitions
class GroupCompetitorWidget extends StatelessWidget {
  Group group;

  late List<Reference> groupMembersImageReferences;

  GroupCompetitorWidget({
    required this.group,
  });

  Future<String> retrieveGroupImageURL() {
    return reference.child(group.groupImageURL).getDownloadURL();
  }

  AspectRatio retrieveGroupImage(String groupImageURL) {
    // The Image Of A Store On Which The Winner Won From.
    return AspectRatio(
      aspectRatio: 5 / 2,
      /*child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: backgroundResourcesColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(groupImageURL)),
        ),
      ), */
      child: CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        imageUrl: groupImageURL,
        fadeOutCurve: Curves.easeOutExpo,
        imageBuilder: (c, provider) {
          return Container(
            //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
            decoration: BoxDecoration(
              color: backgroundResourcesColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(fit: BoxFit.cover, image: provider),
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
  }

  Future<ListResult> findGroupMembersImageURLs() async {
    String hostName = Converter.townOrInstitutionAsString(
            group.groupTownOrInstitution.townOrInstitutionName)
        .toLowerCase();
    if (hostName.contains('howard college ukzn') &&
        'howard college ukzn'.contains(hostName)) {
      hostName = 'ukzn'; // Supposed to be ukzn-howard
    } else if (hostName.contains('mangosuthu (mut)') &&
        'mangosuthu (mut)'.contains(hostName)) {
      hostName = 'mut';
    }
    return reference
        .child(
            '$hostName/group_members/${group.groupCreatorPhoneNumber}/profile_images')
        .listAll();
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
                ));
          } else if (snapshot.hasError) {
            debug.log(
                "Error Fetching Group Members Images Data - ${snapshot.error}");
            return getCircularProgressBar();
          } else {
            return getCircularProgressBar();
          }
        });
  }

  //Accept A Maximum Of Five Group Members.
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 5,
      ),
      // Group Image
      FutureBuilder(
          future: retrieveGroupImageURL(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return retrieveGroupImage(snapshot.data as String);
            } else if (snapshot.hasError) {
              debug.log(
                  'Error Fetching Group Competitor Image Data - ${snapshot.error}');
              return getCircularProgressBar();
            } else {
              return getCircularProgressBar();
            }
          }),
      const SizedBox(
        height: 5,
      ),
      // Group Members
      FutureBuilder(
          future: findGroupMembersImageURLs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ListResult allDownloadURLs = snapshot.data! as ListResult;

              if (allDownloadURLs.items.length > 12) {
                List<Reference> falseImagesReferences = [];
                int randomStartIndex =
                    Random().nextInt(allDownloadURLs.items.length - 12);
                int randomNumberOfGroupMembers = 1 + Random().nextInt(12);

                for (int index = randomStartIndex;
                    index < randomStartIndex + randomNumberOfGroupMembers;
                    index++) {
                  falseImagesReferences.add(allDownloadURLs.items[index]);
                }
                groupMembersImageReferences = falseImagesReferences;
              } else {
                groupMembersImageReferences = allDownloadURLs.items;
              }

              return createGroupMembers(context);
            } else if (snapshot.hasError) {
              debug
                  .log("Error Fetching Group Members Data - ${snapshot.error}");
              return getCircularProgressBar();
            } else {
              return getCircularProgressBar();
            }
          }),
      const SizedBox(
        height: 5,
      ),
    ]);
  }
}
