import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/competitions/activation_request.dart';
import '../../models/converter.dart';
import '../utils/globals.dart';

typedef OnMoneyBackChange = Function(String, String);

class ActivationInfoWidget extends StatefulWidget {
  ActivationRequest request;
  OnMoneyBackChange onMoneyBackChange;
  ActivationInfoWidget(
      {Key? key, required this.request, required this.onMoneyBackChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ActivtionInfoWidgetState();
}

class ActivtionInfoWidgetState extends State<ActivationInfoWidget> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = false;
  }

  Widget activationRequestInfo() => Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 2),
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.request.groupFK,
                          style: TextStyle(
                              fontSize: listTileText1FontSize,
                              color: MyApplication.attractiveColor1,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.request.voucher,
                          style: TextStyle(
                              fontSize: listTileText1FontSize,
                              color: MyApplication.storesTextColor,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          Converter.toVoucherAsString(
                                      widget.request.voucherType)
                                  .contains('Blue')
                              ? 'Blue'
                              : Converter.toVoucherAsString(
                                  widget.request.voucherType),
                          style: TextStyle(
                              fontSize: listTileText1FontSize - 2,
                              color: MyApplication.logoColor1,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return MyApplication.logoColor2;
                          /*if (states.contains(MaterialState.selected)) {
                          return MyApplication
                              .logoColor1; // Fill color when selected
                        }
                        return MyApplication
                            .storeInfoTextColor; */ // Default fill color
                        },
                      ),

                      value: isSelected, // The current state of the checkbox
                      onChanged: (bool? newValue) {
                        setState(() {
                          widget.onMoneyBackChange(widget.request.groupFK,
                              widget.request.activationRequestId);
                          isSelected =
                              newValue!; // Update the state when changed
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return activationRequestInfo();
  }
}
