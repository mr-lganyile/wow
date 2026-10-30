import '../utils/globals.dart';
import '/controllers/competition_controller.dart';
import '/screens/competition/group_competitor_widget.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as debug;

import '../../controllers/hosting_area_controller.dart';
import '../../../main.dart';
import '../../models/hosting areas/hosted_draw.dart';
import '../../models/hosting areas/draw_grand_price.dart';
import 'grand_price_widget.dart';

typedef OnCurrentlyViewedUpdate = Function(bool);

typedef OnCurrentGroupSet = Function(GroupCompetitorWidget);

// Branch : competition_resources_crud ->  view_competitions
class WaitWidget extends StatefulWidget {
  HostedDraw hostedDraw;

  bool? showPlayIcon;
  bool showRemainingTime;
  bool showAlarm;

  Duration? remainingDuration;
  OnCurrentlyViewedUpdate? onCurrentlyViewedUpdate;

  List<int>? grandPricesOrder;
  bool? pickWonPrice;

  int? pickingMultipleInSeconds;
  int? countDownMultiple;

  // Not used yet, but will be later to avoid flickuring of group members images.
  OnCurrentGroupSet? onCurrentGroupSet;

  int? groupPickingStartTime;

  WaitWidget({
    Key? key,
    this.groupPickingStartTime,
    required this.hostedDraw,
    this.remainingDuration,
    this.onCurrentlyViewedUpdate,
    this.showPlayIcon = false,
    this.pickWonPrice = false,
    this.showRemainingTime = false,
    this.showAlarm = true,
    this.grandPricesOrder = const [],
    this.pickingMultipleInSeconds,
    this.countDownMultiple,
    this.onCurrentGroupSet,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WaitWidgetState();
}

class WaitWidgetState extends State<WaitWidget> {
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  CompetitionController competitionController =
      CompetitionController.competitionController;

  late Stream<List<DrawGrandPrice>> drawGrandPricesStream;
  late List<DrawGrandPrice> drawGrandPrices;
  List<GrandPriceWidget> grandPricesWidgets = [];
  int currentlyPointedGrandPriceIndex = -1;

  @override
  void initState() {
    super.initState();
    drawGrandPricesStream = hostingAreaController.findDrawGrandPrices(
      widget.hostedDraw.hostingAreaFK,
      widget.hostedDraw.hostedDrawId!,
    );
  }

  Widget competitionDayAndTime() {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Start On',
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            widget.hostedDraw.startOnDay(),
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            widget.hostedDraw.startOnTime(),
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget remainingTime(int minutes, int seconds) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // 'Remaining Time ',
            'Count Down ',
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            // '$minutes:$seconds',
            '${(minutes * 60 + seconds) ~/ widget.countDownMultiple!}',
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.storesSpecialTextColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> retrieveGrandPriceImageURL(String grandPriceImageURL) {
    return reference.child(grandPriceImageURL).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    int? minutes;
    int? seconds;

    if (widget.showRemainingTime) {
      int initialDuration = widget.remainingDuration!.inSeconds;

      minutes = initialDuration ~/ 60;
      seconds = initialDuration % 60;
    }

    // Sometimes the returned snapshot has empty data.
    return Column(
      children: [competitionDayAndTime(), displayGrandPrices(minutes, seconds)],
    );
    // return displayGrandPrices(minutes, seconds);
  }

  Widget displayGrandPrices(minutes, seconds) => StreamBuilder(
    stream: drawGrandPricesStream,
    builder: ((context, snapshot) {
      if (snapshot.hasData) {
        drawGrandPrices = snapshot.data as List<DrawGrandPrice>;

        return Column(
          children: [
            (widget.showRemainingTime)
                ? remainingTime(minutes!, seconds!)
                : const SizedBox.shrink(),
            _buildGrandPrices(),
          ],
        );
      } else if (snapshot.hasError) {
        debug.log(
          'Error Fetching All Draw Grand Prices Data - ${snapshot.error}',
        );
        return getCircularProgressBar();
      } else {
        return getCircularProgressBar();
      }
    }),
  );

  void addGrandPricesWidgets() {
    for (int i = 0; i < drawGrandPrices.length; i++) {
      grandPricesWidgets.add(
        GrandPriceWidget(
          showBall: widget.pickWonPrice!,
          isPointed: false,
          grandPriceImageURL: drawGrandPrices[i].imageURL,
        ),
      );
    }
  }

  Widget _buildGrandPrices() {
    Widget grid;

    double horizontalGrandPriceSpaceces = 10;

    if (drawGrandPrices.isEmpty) {
      return const Center(child: Text("No Grand Prices Available"));
    }

    if (grandPricesWidgets.isEmpty) {
      addGrandPricesWidgets();
    }

    int currentIndex = -1;
    if (widget.grandPricesOrder!.isNotEmpty) {
      currentIndex =
          widget.remainingDuration!.inSeconds ~/
          widget.pickingMultipleInSeconds!;
      currentlyPointedGrandPriceIndex = widget.grandPricesOrder![currentIndex];
    }

    switch (drawGrandPrices.length) {
      case 4:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  retrieveStack(0),
                  const Expanded(child: SizedBox.shrink()),
                  // Top Right Grand Price.
                  retrieveStack(1),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [showAppropriateIcon()],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  retrieveStack(2),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  retrieveStack(3),
                ],
              ),
            ),
          ],
        );
        break;
      case 5:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  retrieveStack(0),
                  showAppropriateIcon(),
                  // Top Right Grand Price.
                  retrieveStack(1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: SizedBox.shrink()),
                // Middle Grand Price.
                retrieveStack(2),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: horizontalGrandPriceSpaceces),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  retrieveStack(3),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  retrieveStack(4),
                ],
              ),
            ),
          ],
        );
        break;
      case 6:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: horizontalGrandPriceSpaceces,
                bottom: horizontalGrandPriceSpaceces,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  retrieveStack(0),
                  showAppropriateIcon(),
                  // Top Right Grand Price.
                  retrieveStack(1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                retrieveStack(2),
                const Expanded(child: SizedBox.shrink()),
                // Middle Right Grand Price.
                retrieveStack(3),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: horizontalGrandPriceSpaceces,
                bottom: horizontalGrandPriceSpaceces,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  retrieveStack(4),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  retrieveStack(5),
                ],
              ),
            ),
          ],
        );
        break;
      case 7:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: horizontalGrandPriceSpaceces,
                bottom: horizontalGrandPriceSpaceces,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  retrieveStack(0),
                  showAppropriateIcon(),
                  // Top Right Grand Price.
                  retrieveStack(1),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Left Grand Price.
                retrieveStack(2),
                // Middle Right Grand Price.
                retrieveStack(3),
                // Middle Grand Price.
                retrieveStack(4),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: horizontalGrandPriceSpaceces,
                bottom: horizontalGrandPriceSpaceces,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  retrieveStack(5),
                  const Expanded(child: SizedBox.shrink()),
                  // Bottom Right Grand Price.
                  retrieveStack(6),
                ],
              ),
            ),
          ],
        );
        break;
      default:
        grid = Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: horizontalGrandPriceSpaceces,
                bottom: horizontalGrandPriceSpaceces,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Left Grand Price.
                  retrieveStack(0),
                  // Top Middle Grand Price.
                  retrieveStack(1),
                  // Top Right Grand Price.
                  retrieveStack(2),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Middle Right Grand Price.
                retrieveStack(3),
                showAppropriateIcon(),
                // Middle Left Grand Price.
                retrieveStack(4),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: horizontalGrandPriceSpaceces,
                bottom: horizontalGrandPriceSpaceces,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bottom Left Grand Price.
                  retrieveStack(5),
                  // Middle Bottom Grand Price.
                  retrieveStack(6),
                  // Bottom Right Grand Price.
                  retrieveStack(7),
                ],
              ),
            ),
          ],
        );
    }

    return grid;
  }

  Stack retrieveStack(int grandPriceIndex) {
    return Stack(
      children: [
        grandPricesWidgets[grandPriceIndex],
        grandPriceIndex == currentlyPointedGrandPriceIndex
            ? Center(
                child: Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyApplication.attractiveColor2,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget showAppropriateIcon() {
    if (widget.showRemainingTime || widget.pickWonPrice!) {
      return const Expanded(child: SizedBox.shrink());
    } else {
      return buildPlayIcon();
    }
  }

  Widget buildPlayIcon() => Expanded(
    child: SizedBox(
      height: MyApplication.alarmIconFontSize,
      width: MyApplication.alarmIconFontSize,
      child: !widget.showPlayIcon!
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: () {
                widget.onCurrentlyViewedUpdate!(true);
              },
              icon: Icon(
                Icons.play_circle,
                color: MyApplication.logoColor1,
                size: MyApplication.alarmIconFontSize,
              ),
            ),
    ),
  );
}
