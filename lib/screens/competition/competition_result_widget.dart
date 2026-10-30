import 'package:cached_network_image/cached_network_image.dart';

import '/models/hosting areas/draw_grand_price.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/converter.dart';
import '../../models/users/group.dart';

import 'dart:developer' as debug;

import '../utils/globals.dart';

// Branch : competition_resources_crud ->  view_competitions
class CompetitionResultWidget extends StatelessWidget {
  Group wonGroup;
  DrawGrandPrice wonPrice;
  DateTime competitionEndTime;

  late List<Reference> groupMembersImageReferences;

  CompetitionResultWidget({
    required this.wonGroup,
    required this.wonPrice,
    required this.competitionEndTime,
  });

  Column retrieveGroupDetails(BuildContext context) {
    String townOrInstitution = Converter.townOrInstitutionAsString(
      wonGroup.groupTownOrInstitution.townOrInstitutionName,
    );

    String townOrInstitutionLabel;

    if (townOrInstitution.contains('DUT') ||
        townOrInstitution.contains('UKZN') ||
        townOrInstitution.contains('MUT')) {
      townOrInstitutionLabel = 'Group Institution';
    } else {
      townOrInstitutionLabel = 'Group Town';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group name details
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Group Name',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.storesTextColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  wonGroup.groupName,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storesTextColor,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Group Town/Institution Info
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                townOrInstitutionLabel,
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.storesTextColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Converter.townOrInstitutionAsString(
                    wonGroup.groupTownOrInstitution.townOrInstitutionName,
                  ),
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storesTextColor,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Group Area Info
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Group Area',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.storesTextColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Converter.asString(wonGroup.groupArea.sectionName),
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storesTextColor,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Group Location
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Group Location',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.logoColor1,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  wonGroup.groupSpecificArea!,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.logoColor2,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column retrieveWonPriceInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Won price
        Row(
          children: [
            Expanded(
              child: Text(
                'Won Price',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.logoColor1,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  wonPrice.description,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.logoColor2,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Lucky Date
        Row(
          children: [
            Expanded(
              child: Text(
                'Lucky Date',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.logoColor1,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  competitionEndTime.toString().substring(0, 16),
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.logoColor2,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Group Name
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Group Name',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.logoColor1,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                wonGroup.groupName,
                style: TextStyle(
                  color: MyApplication.logoColor2,
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> findWonPriceImageURL() async {
    return reference.child(wonPrice.imageURL).getDownloadURL();
  }

  AspectRatio retrieveWonPriceImage(
    BuildContext context,
    String wonGrandPriceImageURL,
  ) {
    return AspectRatio(
      aspectRatio: 8 / 2,
      /* child: Container(
        decoration: BoxDecoration(
          color: backgroundResourcesColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(wonGrandPriceImageURL),
          ),
        ),
      ), */
      child: CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        imageUrl: wonGrandPriceImageURL,
        fadeOutCurve: Curves.easeOutExpo,
        imageBuilder: (c, provider) {
          return Container(
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

  Future<String> findGroupCreatorImageURL() {
    return reference.child(wonGroup.groupCreatorImageURL).getDownloadURL();
  }

  Future<ListResult> findGroupMembersImageURLs() async {
    String hostName = Converter.townOrInstitutionAsString(
      wonGroup.groupTownOrInstitution.townOrInstitutionName,
    ).toLowerCase();

    if (hostName.contains('howard college ukzn') &&
        'howard college ukzn'.contains(hostName)) {
      hostName = 'ukzn'; // Supposed to be ukzn-howard
    } else if (hostName.contains('mangosuthu (mut)') &&
        'mangosuthu (mut)'.contains(hostName)) {
      hostName = 'mut';
    }
    debug.log('$hostName/group_members/${wonGroup.groupId}/profile_images');

    return reference
        .child('$hostName/group_members/${wonGroup.groupId}/profile_images')
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

  @override
  Widget build(BuildContext context) {
    String townOrInstitution = Converter.townOrInstitutionAsString(
      wonGroup.groupTownOrInstitution.townOrInstitutionName,
    );

    String townOrInstitutionLabel;

    if (townOrInstitution.contains('DUT') ||
        townOrInstitution.contains('UKZN') ||
        townOrInstitution.contains('MUT')) {
      townOrInstitutionLabel = 'Group Institution';
    } else {
      townOrInstitutionLabel = 'Group Town';
    }
    return SizedBox(
      //height: 550,
      child: Column(
        children: [
          const SizedBox(height: 5),

          // Group Town/Institution
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  townOrInstitutionLabel,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.logoColor1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    townOrInstitution,
                    style: TextStyle(
                      fontSize: MyApplication.infoTextFontSize,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.logoColor2,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Group Area Info
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Group Area',
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    color: MyApplication.logoColor1,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Converter.asString(wonGroup.groupArea.sectionName),
                    style: TextStyle(
                      fontSize: MyApplication.infoTextFontSize,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.logoColor2,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Group Location
          wonGroup.groupSpecificArea == null
              ? const SizedBox.shrink()
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Group Location',
                        style: TextStyle(
                          fontSize: MyApplication.infoTextFontSize,
                          fontWeight: FontWeight.bold,
                          color: MyApplication.logoColor1,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          wonGroup.groupSpecificArea!,
                          style: TextStyle(
                            fontSize: MyApplication.infoTextFontSize,
                            fontWeight: FontWeight.bold,
                            color: MyApplication.logoColor2,
                            decoration: TextDecoration.none,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

          Container(
            margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
            child: Column(
              children: [
                // Creator & Won Price Image
                SizedBox(
                  height: 150,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      children: [
                        // Winner
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                                bottom: 5,
                              ),
                              child: Column(
                                children: [
                                  FutureBuilder(
                                    future: findGroupCreatorImageURL(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        /* return CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              snapshot.data as String),
                                        ); */
                                        return CachedNetworkImage(
                                          key: UniqueKey(),
                                          fit: BoxFit.cover,
                                          imageUrl: snapshot.data as String,
                                          fadeOutCurve: Curves.easeOutExpo,
                                          imageBuilder: (c, provider) {
                                            return CircleAvatar(
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
                                          'Error Fetching Winner Image - ${snapshot.error}',
                                        );
                                        return getCircularProgressBar();
                                      } else {
                                        return getCircularProgressBar();
                                      }
                                    },
                                  ),
                                  Text(
                                    'Leader',
                                    style: TextStyle(
                                      color: MyApplication.logoColor1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    wonGroup.groupCreatorUsername,
                                    style: TextStyle(
                                      color: MyApplication.logoColor2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // WonPrice Image
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 140,
                            child: FutureBuilder(
                              future: findWonPriceImageURL(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return retrieveWonPriceImage(
                                    context,
                                    snapshot.data as String,
                                  );
                                } else if (snapshot.hasError) {
                                  debug.log(
                                    'Error Fetching Won Price Image - ${snapshot.error}',
                                  );
                                  return getCircularProgressBar();
                                } else {
                                  return getCircularProgressBar();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: SizedBox(height: 70, child: retrieveWonPriceInfo(context)),
          ),

          // Members Of A Group
          FutureBuilder(
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
                debug.log(
                  "Error Fetching Group Members Data - ${snapshot.error}",
                );
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
