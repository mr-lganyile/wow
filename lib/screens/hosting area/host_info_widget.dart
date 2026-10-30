import 'package:cached_network_image/cached_network_image.dart';

import '../../controllers/group_controller.dart';
import '../../models/locations/supported_town_or_institution.dart';
import '../competition/competition_finished_widget.dart';
import '../competition/simple_group_competitor_widget.dart';
import '../competition/won_grand_price_widget.dart';
import '../utils/globals.dart';
import '/controllers/competition_controller.dart';
import '/screens/competition/competition_result_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../controllers/hosting_area_controller.dart';
import '../../models/competitions/competition.dart';
import '../../models/competitions/count_down_clock.dart';
import '../../models/users/group.dart';
import '../../models/hosting areas/hosted_draw.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/converter.dart';

import 'dart:developer' as debug;

import '../../models/hosting areas/hosted_draw_state.dart';
import '../../models/hosting areas/host_info.dart';
import '../competition/group_competitor_widget.dart';
import '../competition/no_competition_widget.dart';
import '../competition/wait_widget.dart';
import 'notification_display_widget.dart';

// Branch : store_resources_crud ->  view_stores_front_end
class HostInfoWidget extends StatefulWidget {
  HostInfo hostInfo;

  int wonPriceIndex = -1; // For Testing Purposes Only.
  String wonGroupLeaderPhoneNumber = "-"; // For Testing Purposes Only.

  HostInfoWidget({super.key, required this.hostInfo});

  @override
  State<StatefulWidget> createState() => HostInfoWidgetState();
}

class HostInfoWidgetState extends State<HostInfoWidget> {
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  GroupController groupController = GroupController.instance;
  late CompetitionController competitionController;
  late Stream<DocumentSnapshot> hostInfoSteam;

  late CountDownClock countDownClock;
  late DocumentReference competitionReference;
  late Competition competition;

  bool hasUpdatedNextDraw = false;

  // =======================================================

  // Not used yet, but will be later to avoid flickuring of group members images.
  late Widget currentGroupCompetitorWidget;
  CompetitionResultWidget? competitionResultWidget;
  // =======================================================

  List<String>? competitorsOrder;
  bool? pickWonGroup;
  // late Stream<List<Group>> groupsStream;
  late List<Group> groups;
  List<GroupCompetitorWidget> groupCompetitorsWidgets = [];
  List<SimpleGroupCompetitorWidget> simpleGroupCompetitorsWidgets = [];

  // Not used yet, but will be later to avoid flickuring of group members images.
  OnCurrentGroupSet? onCurrentGroupSet;

  int currentlyPointedGroupCompetitorIndex = -1;
  late SupportedTownOrInstitution groupTownOrInstitution;

  @override
  void initState() {
    super.initState();
    competitionController = CompetitionController.competitionController;
    hostInfoSteam = hostingAreaController.retrieveHostInfo(
      widget.hostInfo.hostInfoId,
    );
    groupTownOrInstitution = Converter.toSupportedTownOrInstitution(
      widget.hostInfo.sectionName,
    );
  }

  void updateIsCurrentlyViewed(bool isCurrentlyViewed) {
    setState(() {
      widget.hostInfo.setIsCurrentlyViewed(isCurrentlyViewed);
    });
  }

  void updateCurrentGroupCompetitorWidget(
    GroupCompetitorWidget currentGroupCompetitorWidget,
  ) {
    this.currentGroupCompetitorWidget = currentGroupCompetitorWidget;
  }

  Column retrieveStoreDetails(BuildContext context) {
    // Information About The Hosting Store.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Name Of A Store On Which The Winner Won From.
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Host Name',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.storesTextColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                widget.hostInfo.hostingAreaName,
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.storesTextColor,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),

        // The Address Of A Store On Which The Winner Won From.
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Pick Up Spot',
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.storesTextColor,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                widget.hostInfo.pickUpArea,
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.storesTextColor,
                  decoration: TextDecoration.none,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> retrieveHostingAreaImageURL(String hostingAreaImageURL) {
    return reference.child(hostingAreaImageURL).getDownloadURL();
  }

  AspectRatio retrieveStoreImage(
    BuildContext context,
    String hostingAreaImageURL,
  ) {
    // The Image Of A Store On Which The Winner Won From.
    return AspectRatio(
      aspectRatio: 5 / 2,
      /*child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: backgroundResourcesColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(hostingAreaImageURL)),
        ),
      ), */
      child: CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        imageUrl: hostingAreaImageURL,
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          // Store Image
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FutureBuilder(
              future: retrieveHostingAreaImageURL(
                widget.hostInfo.hostingAreaImageURL,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return retrieveStoreImage(context, snapshot.data as String);
                } else if (snapshot.hasError) {
                  debug.log(
                    'Error Fetching Hosting Area Image - ${snapshot.error}',
                  );
                  return getCircularProgressBar();
                } else {
                  return getCircularProgressBar();
                }
              },
            ),
          ),
          // Store Details
          retrieveStoreDetails(context),
          myStoreState(),
        ],
      ),
    );
  }

  Widget myStoreState() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: StreamBuilder<DocumentSnapshot?>(
        stream: hostingAreaController.retrieveHostedDraw(
          widget.hostInfo.hostInfoId,
          //widget.hostInfo.getCommingDrawId(),
          widget.hostInfo.latestHostedDrawId,
        ), // Use comming draw
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            HostedDraw nextHostedDraw = HostedDraw.fromJson(snapshot.data);

            DateTime latestPast = DateTime.now().subtract(
              const Duration(days: 1),
            );

            if (nextHostedDraw.drawDateAndTime.isBefore(latestPast)) {
              return NoCompetitionWidget(
                hostingAreaId: widget.hostInfo.hostInfoId,
                hostingAreaName: widget.hostInfo.hostingAreaName,
                hostingAreaImageURL: widget.hostInfo.hostingAreaImageURL,
                sectionName: widget.hostInfo.sectionName,
              );
            } else if (nextHostedDraw.hostedDrawState ==
                HostedDrawState.notConvertedToCompetition) {
              hasUpdatedNextDraw = false;
              return WaitWidget(hostedDraw: nextHostedDraw);
            } else {
              return StreamBuilder<DocumentSnapshot>(
                stream: competitionController.findCompetition(
                  nextHostedDraw.hostedDrawId!,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    competition = Competition.fromJson(snapshot.data);

                    int day = nextHostedDraw.drawDateAndTime.day;
                    int month = nextHostedDraw.drawDateAndTime.month;
                    int year = nextHostedDraw.drawDateAndTime.year;
                    int hour = nextHostedDraw.drawDateAndTime.hour;
                    int minute = nextHostedDraw.drawDateAndTime.minute;

                    String collectionId = "$year-$month-$day@${hour}h$minute";

                    competitionReference = snapshot.data!.reference;

                    return readFromcountDownClock(collectionId, nextHostedDraw);
                  } else if (snapshot.hasError) {
                    debug.log(
                      "Error Fetching competition Data - ${snapshot.error}",
                    );
                    return getCircularProgressBar();
                  } else {
                    return getCircularProgressBar();
                  }
                },
              );
            }
          } else if (snapshot.hasError) {
            debug.log(
              "Error Fetching Last Hosted Draw Data - ${snapshot.error}",
            );
            return NoCompetitionWidget(
              hostingAreaId: widget.hostInfo.hostInfoId,
              hostingAreaName: widget.hostInfo.hostingAreaName,
              hostingAreaImageURL: widget.hostInfo.hostingAreaImageURL,
              sectionName: widget.hostInfo.sectionName,
            );
          } else {
            return NoCompetitionWidget(
              hostingAreaId: widget.hostInfo.hostInfoId,
              hostingAreaName: widget.hostInfo.hostingAreaName,
              hostingAreaImageURL: widget.hostInfo.hostingAreaImageURL,
              sectionName: widget.hostInfo.sectionName,
            );
          }
        },
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> readFromcountDownClock(
    String coundDownClockId,
    HostedDraw nextHostedDraw,
  ) {
    return StreamBuilder<DocumentSnapshot>(
      stream: competitionController.retrieveCountDownClock(coundDownClockId),
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          countDownClock = CountDownClock.fromJson(snapshot.data);

          int grandPricePickingDuration =
              competition.grandPricesOrder.length *
              competition.pickingMultipleInSeconds;

          int groupPickingDuration =
              competition.competitorsOrder.length *
              competition.pickingMultipleInSeconds;

          int competitionTotalDuration =
              grandPricePickingDuration +
              competition.timeBetweenPricePickingAndGroupPicking! +
              groupPickingDuration;

          DateTime competitionEndTime = competition.dateTime.add(
            Duration(seconds: competitionTotalDuration),
          );

          // pickingMultipleInSeconds * 20 // Remaining seconds
          if (countDownClock.remainingTime < 0) {
            // Show remaining time before competition starts.
            return WaitWidget(
              hostedDraw: nextHostedDraw,
              remainingDuration: Duration(
                seconds: countDownClock.remainingTime * -1,
              ),
              pickWonPrice: false,
              showPlayIcon: false,
              showAlarm: false,
              countDownMultiple: competition.pickingMultipleInSeconds,
              showRemainingTime: true,
              onCurrentlyViewedUpdate: updateIsCurrentlyViewed,
            );
          }
          // pickingMultipleInSeconds * x => Varies
          // Show grand prices with play icon.
          else if (!widget.hostInfo.isCurrentlyViewed &&
              countDownClock.remainingTime < competitionTotalDuration) {
            return WaitWidget(
              remainingDuration: Duration(
                seconds: countDownClock.remainingTime,
              ),
              hostedDraw: nextHostedDraw,
              pickWonPrice: false,
              showPlayIcon: true,
              showAlarm: false,
              showRemainingTime: false,
              grandPricesOrder: const [],
              onCurrentlyViewedUpdate: updateIsCurrentlyViewed,
            );
          }
          // pickingMultipleInSeconds * 6 // Grand Price Picking
          // Show and pick grand prices.
          else if (widget.hostInfo.isCurrentlyViewed &&
              countDownClock.remainingTime < grandPricePickingDuration) {
            debug.log('Grand Price Picking: ${countDownClock.remainingTime}');
            return WaitWidget(
              remainingDuration: Duration(
                seconds: countDownClock.remainingTime,
              ),
              hostedDraw: nextHostedDraw,
              pickWonPrice: true,
              showAlarm: false,
              grandPricesOrder: competition.grandPricesOrder,
              pickingMultipleInSeconds: competition.pickingMultipleInSeconds,
            );
          }
          // pickingMultipleInSeconds * 3 // Won Price Display
          // Display won price.
          else if (widget.hostInfo.isCurrentlyViewed &&
              countDownClock.remainingTime <
                  grandPricePickingDuration +
                      competition.timeBetweenPricePickingAndGroupPicking!) {
            return WonGrandPriceWidget(wonPrice: competition.wonPrice!);
          }
          // pickingMultipleInSeconds * 200 // Group Picking Max Time or
          // pickingMultipleInSeconds * competitorsOrder.length // Group Picking Max Time
          // Show group picking
          else if (widget.hostInfo.isCurrentlyViewed &&
              countDownClock.remainingTime < competitionTotalDuration) {
            currentlyPointedGroupCompetitorIndex =
                (countDownClock.remainingTime -
                    grandPricePickingDuration -
                    competition.timeBetweenPricePickingAndGroupPicking!) ~/
                competition.pickingMultipleInSeconds;
            return displayGroupCompetitors();
          }
          //  pickingMultipleInSeconds * 2 // Notification Display
          else if (widget.hostInfo.notification != null &&
              widget.hostInfo.notification!.endDate.isAfter(DateTime.now()) &&
              countDownClock.remainingTime <=
                  competitionTotalDuration +
                      competition.pickingMultipleInSeconds * 2) {
            return NotificationDisplayWidget(
              notification: widget.hostInfo.notification!,
            );
          }
          //  pickingMultipleInSeconds * (28 or 30) // Competition Result Display
          // Show Won Price Summary For The Next Certain Amount Of Minute.
          else if (countDownClock.remainingTime <=
              competitionTotalDuration +
                  competition.displayPeriodAfterWinners!) {
            if (widget.hostInfo.isCurrentlyViewed) {
              widget.hostInfo.setIsCurrentlyViewed(false);
            }
            /*
            debug.log(
              'Show won price summary: ${countDownClock.remainingTime} competition.wonGroup ${competition.wonGroup == null}',
            ); */
            return CompetitionResultWidget(
              wonPrice: competition.wonPrice!,
              wonGroup: competition.wonGroup!,
              competitionEndTime: competitionEndTime,
            );
          }
          // Remove the last played draw. [SUPPOSE TO BE PERFORMED IN THE BACKEND]
          else if (widget.hostInfo.drawsOrder != null &&
              widget.hostInfo.drawsOrder!.isNotEmpty &&
              countDownClock.remainingTime >
                  competitionTotalDuration +
                      competition.displayPeriodAfterWinners! +
                      9 &&
              !hasUpdatedNextDraw) {
            hasUpdatedNextDraw = true;
            hostingAreaController.updateDrawsOrder(widget.hostInfo.hostInfoId);
            debug.log('updateDrawsOrder');
            return CompetitionFinishedWidget(endMoment: competitionEndTime);
          }
          // pickingMultipleInSeconds * 12 // Game Over
          else {
            /*if (countDownClock.remainingTime >
                    competitionTotalDuration +
                        competition.displayPeriodAfterWinners! +
                        9 &&
                !competition.isOver) {
              competitionReference.update({"isOver": true});
            }*/
            debug.log('Display Competition Finished');
            return CompetitionFinishedWidget(endMoment: competitionEndTime);
            // return displayGroupCompetitors();
          }
        } else if (snapshot.hasError) {
          debug.log('Error fetching count down clock data ${snapshot.error}');
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      }),
    );
  }

  // Assuming there is a cloud function returning a list of fruit in the backend.
  Future<void> getFruit() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'listFruit',
    );
    final results = await callable();
    List fruit =
        results.data; // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
  }

  Future<void> writeMessage(String message) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'writeMessage',
    );
    final resp = await callable.call(<String, dynamic>{
      'text': 'A message sent from a client device',
    });
    print("result: ${resp.data}");
  }

  Future<void> setWonPriceSummary(String competitionId) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'createWonPriceSummary',
    );
    await callable.call(<String, dynamic>{'competition': competitionId});
  }

  Widget displayGroupCompetitors() {
    if ( /*groupCompetitorsWidgets.isEmpty*/ simpleGroupCompetitorsWidgets
        .isEmpty) {
      return StreamBuilder<List<Group>>(
        // stream: groupsStream,
        stream: groupController.readGroups(
          groupTownOrInstitution.townOrInstitutionNo,
        ),
        // stream: groupController.readAllGroups(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            groups = snapshot.data!;
            debug.log('No Problems, Groups are extracted from DB.');
            addGroupCompetitorsWidgets();
            /*return groupCompetitorsWidgets[
                currentlyPointedGroupCompetitorIndex]; */

            return simpleGroupCompetitorsWidgets[currentlyPointedGroupCompetitorIndex];
          } else if (snapshot.hasError) {
            debug.log(
              'Error Fetching Group Competitors Data - ${snapshot.error}',
            );
            return getCircularProgressBar();
          } else {
            return getCircularProgressBar();
          }
        },
      );
    } else {
      // return groupCompetitorsWidgets[currentlyPointedGroupCompetitorIndex];
      return simpleGroupCompetitorsWidgets[currentlyPointedGroupCompetitorIndex];
    }
  }

  void addGroupCompetitorsWidgets() {
    if ( /*groupCompetitorsWidgets.isEmpty*/ simpleGroupCompetitorsWidgets
        .isEmpty) {
      for (
        int groupCompetitorIndex = 0;
        groupCompetitorIndex < competition.competitorsOrder.length;
        groupCompetitorIndex++
      ) {
        final phoneNumberAndGroupId = competition
            .competitorsOrder[groupCompetitorIndex]
            .split(' ');
        debug.log(
          'Competitor ${phoneNumberAndGroupId[0]} ${phoneNumberAndGroupId[1]}',
        );

        for (int i = 0; i < groups.length; i++) {
          if (groups[i].groupId.compareTo(phoneNumberAndGroupId[1]) == 0) {
            // Below is a group with images included.
            /*
            groupCompetitorsWidgets
                .add(GroupCompetitorWidget(group: groups[i])); */

            simpleGroupCompetitorsWidgets.add(
              SimpleGroupCompetitorWidget(group: groups[i]),
            );
          }
        }
      }
    }
  }
}
