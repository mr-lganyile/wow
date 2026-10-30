import 'package:flutter/material.dart';

import '../../main.dart';

// Branch : competition_resources_crud ->  view_competitions
class RemainingTimeWidget extends StatefulWidget {
  Duration remainingTime;

  RemainingTimeWidget({
    required this.remainingTime,
  });

  @override
  State<RemainingTimeWidget> createState() => RemainingTimeWidgetState();
}

class RemainingTimeWidgetState extends State<RemainingTimeWidget> {
  Widget remainingTime() {
    int minutes = widget.remainingTime.inSeconds ~/ 60;
    int seconds = widget.remainingTime.inSeconds % 60;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              //'Remaining Time ',
              'Count Down',
              style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.storesSpecialTextColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
            Text(
              // '$minutes:$seconds',
              '${widget.remainingTime.inSeconds}',
              style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.storesSpecialTextColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => remainingTime();
}
