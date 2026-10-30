import 'package:flutter/material.dart';

import '../../main.dart';

// Branch : group_resources_crud ->  create_group_resources_front_end
class SingleMemberTextField extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  bool isForUserName;
  int memberIndex;

  SingleMemberTextField({
    required this.controller,
    required this.labelText,
    required this.memberIndex,
    this.isForUserName = true,
  });

  @override
  State<StatefulWidget> createState() => SingleMemberTextFieldState();
}

class SingleMemberTextFieldState extends State<SingleMemberTextField> {
  @override
  Widget build(BuildContext context) => TextField(
    keyboardType: widget.isForUserName
        ? TextInputType.name
        : TextInputType.number,
    maxLength: widget.isForUserName ? 20 : 10,
    style: TextStyle(color: MyApplication.logoColor1),
    cursorColor: MyApplication.logoColor1,
    controller: widget.controller,
    decoration: InputDecoration(
      labelText: widget.labelText,
      prefixIcon: widget.isForUserName
          ? Icon(Icons.account_circle, color: MyApplication.logoColor1)
          : Icon(Icons.phone, color: MyApplication.logoColor1),
      labelStyle: TextStyle(fontSize: 14, color: MyApplication.logoColor2),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: MyApplication.logoColor2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: MyApplication.logoColor2),
      ),
    ),
    obscureText: false,
  );
}
