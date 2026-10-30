import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/competition_controller.dart';
import '../../main.dart';

import '../../models/converter.dart';
import '../../models/competitions/won_price_summary.dart';
import 'dart:developer' as debug;

import '../utils/globals.dart';
import 'won_price_summary_comments_widget.dart';

// Branch : won_price_summary_resources_crud -> view_won_price_summaries
class WonPriceSummaryWidget extends StatefulWidget {
  WonPriceSummary wonPriceSummary;
  WonPriceSummaryWidget({required this.wonPriceSummary});

  @override
  State createState() => WonPriceSummaryWidgetState();
}

class WonPriceSummaryWidgetState extends State<WonPriceSummaryWidget> {
  late List<Reference> groupMembersImageReferences;

  CompetitionController competitionController =
      CompetitionController.competitionController;

  WonPriceSummaryWidgetState();

  Column retrieveGroupDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group name details
        Row(
          children: [
            Expanded(
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.wonPriceSummary.groupName,
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

        // Group section details
        Row(
          children: [
            Expanded(
              child: Text(
                'Group Home',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.storesTextColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Converter.asString(
                    widget.wonPriceSummary.groupArea.sectionName,
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

        // Group area details
        Row(
          children: [
            Expanded(
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Converter.townOrInstitutionAsString(
                    widget
                        .wonPriceSummary
                        .townOrInstitution
                        .townOrInstitutionName,
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
      ],
    );
  }

  Column retrieveGroupAndPickUpInfo(BuildContext context) {
    String groupArea = Converter.asString(
      widget.wonPriceSummary.groupArea.sectionName,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Area
        Row(
          children: [
            Expanded(
              child: Text(
                'Group Area',
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
                  groupArea,
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
        widget.wonPriceSummary.groupSpecificArea == null
            ? const SizedBox.shrink()
            : Row(
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
                        widget.wonPriceSummary.groupSpecificArea!,
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

        // Pick Up Spot
        Row(
          children: [
            Expanded(
              child: Text(
                'Pick Up Spot',
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
                  widget.wonPriceSummary.pickUpSpot,
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

  // ===================Won Price Display Start===================
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
                  widget.wonPriceSummary.grandPriceDescription,
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
                  widget.wonPriceSummary.wonDate.toString().substring(0, 16),
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

  Future<String> findWonPriceImageURL() async {
    return reference
        .child(widget.wonPriceSummary.wonGrandPriceImageURL)
        .getDownloadURL();
  }

  AspectRatio retrieveWonPriceImage(
    BuildContext context,
    String wonGrandPriceImageURL,
  ) {
    return AspectRatio(
      aspectRatio: 8 / 2,
      /*child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: backgroundResourcesColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(wonGrandPriceImageURL),
          ),
        ),
      ),*/
      child: CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        imageUrl: wonGrandPriceImageURL,
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

  Future<String> findGroupCreatorImageURL() {
    return reference
        .child(widget.wonPriceSummary.groupCreatorImageURL)
        .getDownloadURL();
  }

  // ===================Won Price Display Ends===================

  // ===================Group Members Display Start===================
  Future<ListResult> findGroupMembersImageURLs() async {
    String host = widget.wonPriceSummary.hostName.toLowerCase();

    return reference
        .child(
          '$host/group_members/${widget.wonPriceSummary.wonGroupId}/profile_images',
        )
        .listAll();
  }

  Widget createGroupParticipant(BuildContext context, int memberIndex) {
    return FutureBuilder(
      future: groupMembersImageReferences[memberIndex].getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundResourcesColor,
              ),
              /* child: CircleAvatar(
                  backgroundColor: backgroundResourcesColor,
                  radius: MediaQuery.of(context).size.width / 8,
                  backgroundImage: NetworkImage(snapshot.data as String),
                ), */
              child: CachedNetworkImage(
                key: UniqueKey(),
                fit: BoxFit.cover,
                imageUrl: snapshot.data as String,
                fadeOutCurve: Curves.easeOutExpo,
                imageBuilder: (c, provider) {
                  return CircleAvatar(
                    backgroundColor: backgroundResourcesColor,
                    radius: MediaQuery.of(context).size.width / 8,
                    backgroundImage: provider,
                  );
                },
                placeholder: (c, s) {
                  return getCircularProgressBar();
                },
                errorWidget: (c, s, d) {
                  return getCircularProgressBar();
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          debug.log(
            "Error Fetching Group Participants Data - ${snapshot.error}",
          );
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
  // ===================Group Members Display End===================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 550,
      child: Column(
        children: [
          // Host Name, Group Home & Pick Up Spot
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                // Host Name [Group Name]
                SizedBox(
                  height: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${widget.wonPriceSummary.hostName} [${widget.wonPriceSummary.groupName}]',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyApplication.attractiveColor1,
                        decoration: TextDecoration.none,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Group Home & Pick Up Spot
                SizedBox(
                  height: 70,
                  child: retrieveGroupAndPickUpInfo(context),
                ),
                const SizedBox(height: 5),
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
                                          backgroundColor:
                                              backgroundResourcesColor,
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
                                              backgroundColor:
                                                  backgroundResourcesColor,
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
                                    widget.wonPriceSummary.groupCreatorUsername,
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
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: SizedBox(height: 50, child: retrieveWonPriceInfo(context)),
          ),

          // Members Of A Group
          FutureBuilder(
            future: findGroupMembersImageURLs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ListResult allDownloadURLs = snapshot.data! as ListResult;
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
          const SizedBox(height: 15),

          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Get.to(
                    () => WonPriceSummaryCommentsWidgets(
                      wonPriceSummaryFK:
                          widget.wonPriceSummary.wonPriceSummaryId,
                    ),
                  );
                },
                icon: Icon(
                  Icons.message,
                  size: 30,
                  color: MyApplication.logoColor1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
