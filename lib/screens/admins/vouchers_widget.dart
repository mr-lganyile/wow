import '/models/users/admin.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';
import '../../controllers/group_controller.dart';
import '../../main.dart';
import '../../models/competitions/activation_request.dart';
import '../../models/converter.dart';
import '../utils/globals.dart';
import 'dart:developer' as debug;

import 'activation_info_widget.dart';

class VouchersWidget extends StatelessWidget {
  GroupController groupController = GroupController.instance;
  AdminController adminController = AdminController.adminController;
  late Stream<List<ActivationRequest>> activationRequestsStream;
  late Stream<List<Admin>> adminControllerStream;
  TextEditingController viewerAdminEditingController = TextEditingController();

  Map<String, String> relationships = {};

  late Set<String> items = {};
  late DropdownButton2<String> dropDowButton;

  void initialize() {
    activationRequestsStream =
        adminController.readNotYetSentToMoneyCollectorsActivationRequests();
    adminControllerStream =
        adminController.readNotAdminType(AdminType.groupRegistery);
  }

  void addMoney(String groupFK, String activationReqeustId) {
    if (relationships.containsKey('$groupFK $activationReqeustId')) {
      relationships.remove('$groupFK $activationReqeustId');
    } else {
      relationships.addIf(true, '$groupFK $activationReqeustId', 'yellow');
    }
  }

  Widget proceedButton() => Builder(builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              color: MyApplication.logoColor1,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              )),
          child: InkWell(
            onTap: () async {
              await adminController.saveMoneyBag(relationships);
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
      });

  @override
  Widget build(BuildContext context) {
    initialize();
    return Column(children: [
      const SizedBox(
        height: 5,
      ),
      // Money Collector's Phone Number
      GetBuilder<AdminController>(builder: (_) {
        return StreamBuilder<List<Admin>>(
          stream: adminControllerStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Set<String> dbItems = {};
              for (int requestIndex = 0;
                  requestIndex < snapshot.data!.length;
                  requestIndex++) {
                dbItems.add(
                    '${snapshot.data![requestIndex].phoneNumber} @${Converter.townOrInstitutionAsString(snapshot.data![requestIndex].townOrInstitution)} ${snapshot.data![requestIndex].userId}');
              }
              items = dbItems;
              return GetBuilder<GroupController>(builder: (_) {
                return pickMoneyCollector(context);
              });
            } else if (snapshot.hasError) {
              debug.log(
                  "Error Fetching Supported Town Or Institution Data - ${snapshot.error}");
              return getCircularProgressBar();
            } else {
              return getCircularProgressBar();
            }
          },
        );
      }),

      const SizedBox(
        height: 5,
      ),
      Expanded(
        child: StreamBuilder<List<ActivationRequest>>(
            stream: activationRequestsStream,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<ActivationRequest> activationRequests =
                    snapshot.data as List<ActivationRequest>;
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListView.builder(
                      itemCount: activationRequests.length,
                      itemBuilder: ((context, index) {
                        return ActivationInfoWidget(
                            onMoneyBackChange: addMoney,
                            request: activationRequests[index]);
                      })),
                );
              } else if (snapshot.hasError) {
                print('Error Activation Request Data ${snapshot.error}');
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            })),
      ),

      const SizedBox(
        height: 5,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: proceedButton(),
      ),
    ]);
  }

  Widget pickMoneyCollector(BuildContext context) {
    dropDowButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(
            Icons.admin_panel_settings,
            size: 22,
            color: MyApplication.logoColor1,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              'Money Collector',
              style: TextStyle(
                fontSize: 14,
                color: MyApplication.logoColor2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: items
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.logoColor1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      value: adminController.moneyCollectorInfo,
      onChanged: (String? value) {
        adminController.setMoneyCollectorInfo(value!);
      },
      buttonStyleData: ButtonStyleData(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.90,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: MyApplication.logoColor2,
          ),
          color: MyApplication.scaffoldColor,
        ),
        elevation: 0,
      ),
      iconStyleData: IconStyleData(
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
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
}
