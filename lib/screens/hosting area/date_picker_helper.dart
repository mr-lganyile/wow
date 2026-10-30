import 'package:flutter/material.dart';

import '../../main.dart';

typedef MyCallBack = Function();

class DatePickerHelper extends StatelessWidget {
  final MyCallBack onClicked;

  DatePickerHelper({Key? key, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClicked,
      color: Colors.white,
      iconSize: MediaQuery.of(context).size.width * 0.15,
      icon: Icon(Icons.date_range, color: MyApplication.logoColor2),
    );
  }
}
