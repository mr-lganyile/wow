import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/group_controller.dart';
import '../../controllers/hosting_area_controller.dart';
import '../../main.dart';
import '../../models/converter.dart';
import '../utils/globals.dart';
import 'date_picker.dart';
import 'dart:developer' as debug;
import 'draw_grand_price_creation_widget.dart';
import 'time_picker.dart';

class HostedDrawRegistrationWidget extends StatefulWidget {
  const HostedDrawRegistrationWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HostedDrawRegistrationWidgetState();
}

class HostedDrawRegistrationWidgetState
    extends State<HostedDrawRegistrationWidget> {
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  GroupController groupController = GroupController.instance;

  TextEditingController adminCodeEditingController = TextEditingController();

  TextEditingController description1EditingController = TextEditingController();

  TextEditingController description2EditingController = TextEditingController();

  TextEditingController description3EditingController = TextEditingController();

  TextEditingController description4EditingController = TextEditingController();

  TextEditingController description5EditingController = TextEditingController();

  late DropdownButton2<String> dropDowButton;
  late DropdownButton2<String> phoneNumbersDropDownButton;
  late List<String> phoneNumbersItems;

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.black,
    child: GetBuilder<HostingAreaController>(
      builder: (_) {
        return hostingAreaController.hasAcceptableAdminCredentials()
            ? buildHostedDraw()
            : adminEntrance();
      },
    ),
  );

  Widget adminEntrance() => SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/logo.png')),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 5),
        /*Text(
              'Alco',
              style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.logoColor1,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ), */
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            minLines: 1,
            maxLength: 17,
            style: TextStyle(color: MyApplication.logoColor1),
            cursorColor: MyApplication.logoColor1,
            controller: adminCodeEditingController,
            decoration: InputDecoration(
              labelText: 'Entrance Code',
              prefixIcon: Icon(
                Icons.admin_panel_settings,
                color: MyApplication.logoColor1,
              ),
              labelStyle: TextStyle(
                fontSize: 14,
                color: MyApplication.logoColor2,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: MyApplication.logoColor2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: MyApplication.logoColor2),
              ),
            ),
            obscureText: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: proceedButton(),
        ),
      ],
    ),
  );

  String displayTime() {
    if (hostingAreaController.drawDateHour! == -1 ||
        hostingAreaController.drawDateMinute == -1) {
      return 'HH:MM';
    } else {
      String time = '';

      if (hostingAreaController.drawDateHour! < 10) {
        time += '0${hostingAreaController.drawDateHour!}';
      } else {
        time += '${hostingAreaController.drawDateHour!}';
      }

      if (hostingAreaController.drawDateMinute! < 10) {
        time += ':0${hostingAreaController.drawDateMinute!}';
      } else {
        time += ':${hostingAreaController.drawDateMinute!}';
      }

      if ((hostingAreaController.drawDateHour! == 12 &&
              hostingAreaController.drawDateMinute! > 0) ||
          hostingAreaController.drawDateHour! > 12) {
        time += ' PM';
      } else {
        time += ' AM';
      }

      return time;
    }
  }

  String displayDate() {
    if (hostingAreaController.drawDateYear! < 2025 ||
        hostingAreaController.drawDateMonth == -1 ||
        hostingAreaController.drawDateDay == -1) {
      return 'YYY-MM-DD';
    } else {
      String date = '${hostingAreaController.drawDateYear}';

      if (hostingAreaController.drawDateMonth! < 10) {
        date += '-0${hostingAreaController.drawDateMonth}';
      } else {
        date += '-${hostingAreaController.drawDateMonth}';
      }

      if (hostingAreaController.drawDateDay! < 10) {
        date += '-0${hostingAreaController.drawDateDay}';
      } else {
        date += '-${hostingAreaController.drawDateDay}';
      }

      return date;
    }
  }

  Widget buildHostedDraw() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          GetBuilder<HostingAreaController>(
            builder: (_) {
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        DatePicker(),
                        Text(
                          displayDate(),
                          style: TextStyle(
                            color: MyApplication.logoColor2,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TimePicker(),
                        Text(
                          displayTime(),
                          style: TextStyle(
                            color: MyApplication.logoColor2,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          DrawGrandPriceCreationWidget(
            descriptionController: description1EditingController,
            grandPriceIndex: 0,
          ),
          const SizedBox(height: 10),
          DrawGrandPriceCreationWidget(
            descriptionController: description2EditingController,
            grandPriceIndex: 1,
          ),
          const SizedBox(height: 10),
          DrawGrandPriceCreationWidget(
            descriptionController: description3EditingController,
            grandPriceIndex: 2,
          ),
          const SizedBox(height: 10),
          DrawGrandPriceCreationWidget(
            descriptionController: description4EditingController,
            grandPriceIndex: 3,
          ),
          const SizedBox(height: 10),
          DrawGrandPriceCreationWidget(
            descriptionController: description5EditingController,
            grandPriceIndex: 4,
          ),
          const SizedBox(height: 10),
          pickGrandPriceToWinIndex(context),
          const SizedBox(height: 10),
          StreamBuilder<List<String>>(
            stream: groupController.readGroupsPhoneNumbersAndIds(
              Converter.townOrInstitutionAsNumber(
                hostingAreaController.currentHostTownOrInstitution!,
              ),
            ),
            builder: ((c, snapshot) {
              if (snapshot.hasData) {
                debug.log('No of phone Numbers ${snapshot.data!.length}');
                List<String> dbItems = ['N/A N/A'];
                for (
                  int groupIndex = 0;
                  groupIndex < snapshot.data!.length;
                  groupIndex++
                ) {
                  dbItems.add(snapshot.data![groupIndex].toString());
                }

                phoneNumbersItems = dbItems;
                return GetBuilder<GroupController>(
                  builder: (_) {
                    return pickGroupToWin(context);
                  },
                );
              } else if (snapshot.hasError) {
                debug.log(
                  "Error Fetching Groups [Group To Win] - ${snapshot.error}",
                );
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            }),
          ),
          const SizedBox(height: 10),
          createDrawButton(),
        ],
      ),
    ),
  );

  bool hasPickedAllPrices() {
    if (description1EditingController.text.isEmpty ||
        description2EditingController.text.isEmpty ||
        description3EditingController.text.isEmpty ||
        description4EditingController.text.isEmpty ||
        description5EditingController.text.isEmpty) {
      return false;
    }

    if (hostingAreaController.drawGrandPrice1ImageFile == null ||
        hostingAreaController.drawGrandPrice2ImageFile == null ||
        hostingAreaController.drawGrandPrice3ImageFile == null ||
        hostingAreaController.drawGrandPrice4ImageFile == null ||
        hostingAreaController.drawGrandPrice5ImageFile == null) {
      return false;
    }

    if (hostingAreaController.grandPrice1ImageURL!.isEmpty ||
        hostingAreaController.grandPrice2ImageURL!.isEmpty ||
        hostingAreaController.grandPrice3ImageURL!.isEmpty ||
        hostingAreaController.grandPrice4ImageURL!.isEmpty ||
        hostingAreaController.grandPrice5ImageURL!.isEmpty) {
      return false;
    }

    hostingAreaController.setDescription(0, description1EditingController.text);
    hostingAreaController.setDescription(1, description2EditingController.text);
    hostingAreaController.setDescription(2, description3EditingController.text);
    hostingAreaController.setDescription(3, description4EditingController.text);
    hostingAreaController.setDescription(4, description5EditingController.text);

    return true;
  }

  void cleanForHostedDraw() {
    description1EditingController.clear();
    description2EditingController.clear();
    description3EditingController.clear();
    description4EditingController.clear();
    description5EditingController.clear();
  }

  Widget createDrawButton() => Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    //width: double.maxFinite, visible width
    //height: double.maxFinite visible height
    decoration: BoxDecoration(
      color: MyApplication.logoColor1,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: InkWell(
      onTap: () async {
        if (hostingAreaController.drawDateYear == -1 ||
            hostingAreaController.drawDateMonth == -1 ||
            hostingAreaController.drawDateDay == -1 ||
            hostingAreaController.drawDateHour == -1 ||
            hostingAreaController.drawDateMinute == -1) {
          getSnapbar('Incomplete Info', 'Specify Draw Date & Time.');
          return;
        }
        if (hasPickedAllPrices()) {
          //String adminCode = adminCodeEditingController.text;
          //hostingAreaController.setAdminCode(adminCode);

          if (phoneNumbersDropDownButton.value == null ||
              phoneNumbersDropDownButton.value == 'N/A') {
            getSnapbar('Incomplete Info', 'Specify The Winning Group.');
            return;
          }

          final result = await hostingAreaController.createHostedDraw();

          // Does not go to the next screen.
          if (result == HostedDrawSavingStatus.saved) {
            hostingAreaController.cleanForStoreDraw();
            cleanForHostedDraw();
            hostingAreaController.setAdminCode('');

            Get.back();
            return;
          } else if (result == HostedDrawSavingStatus.incomplete) {
            getSnapbar('Error', 'Incomplete Draw Info');
            return;
          } else if (result == HostedDrawSavingStatus.loginRequired) {
            getSnapbar('Error', 'Not Authorized To Create Draw.');
            return;
          }
        } else {
          getSnapbar('Incomplete', 'Info Missing.');
        }
      },
      child: const Center(
        child: Text(
          'Create Draw',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  Widget proceedButton() => Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    //width: double.maxFinite, visible width
    //height: double.maxFinite visible height
    decoration: BoxDecoration(
      color: MyApplication.logoColor1,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: InkWell(
      onTap: () async {
        hostingAreaController.setAdminCode(adminCodeEditingController.text);
        if (!hostingAreaController.hasAcceptableAdminCredentials()) {
          getSnapbar('Error', 'Not Authorized To Create Draw.');
        }
      },
      child: const Center(
        child: Text(
          'Proceed',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  Widget pickGrandPriceToWinIndex(BuildContext context) {
    dropDowButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(Icons.location_city, size: 22, color: MyApplication.logoColor1),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Pick Grand Price Index',
              style: TextStyle(fontSize: 14, color: MyApplication.logoColor2),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: ['-1', '0', '1', '2', '3', '4']
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.logoColor2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      value: hostingAreaController.grandPriceToWinIndex.toString(),
      onChanged: (String? value) {
        hostingAreaController.setGrandPriceToWinIndex(int.parse(value!));
      },
      buttonStyleData: ButtonStyleData(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: MyApplication.logoColor2),
          color: MyApplication.scaffoldColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: 14,
        iconEnabledColor: MyApplication.logoColor2,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        offset: const Offset(10, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );

    return DropdownButtonHideUnderline(child: dropDowButton);
  }

  Widget pickGroupToWin(BuildContext context) {
    phoneNumbersDropDownButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(Icons.location_city, size: 22, color: MyApplication.logoColor1),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Group To Win Phone',
              style: TextStyle(fontSize: 14, color: MyApplication.logoColor2),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: phoneNumbersItems
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyApplication.logoColor2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      value:
          hostingAreaController.groupToWinPhoneNumber! +
          " " +
          hostingAreaController.groupToWinId!,
      onChanged: (String? value) {
        hostingAreaController.setGroupToWin(value!);
      },
      buttonStyleData: ButtonStyleData(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: MyApplication.logoColor2),
          color: MyApplication.scaffoldColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(Icons.arrow_forward_ios_outlined),
        iconSize: 14,
        iconEnabledColor: MyApplication.logoColor2,
        iconDisabledColor: Colors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        offset: const Offset(10, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all<double>(6),
          thumbVisibility: MaterialStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );

    return DropdownButtonHideUnderline(child: phoneNumbersDropDownButton);
  }
}
