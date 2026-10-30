import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/group_controller.dart';
import '../../main.dart';
import '../../models/converter.dart';
import '../../models/users/group.dart';
import '../utils/globals.dart';

class ActivationRequestWidget extends StatelessWidget {
  TextEditingController voucherCodeEditingController = TextEditingController();
  GroupController groupController = GroupController.instance;

  Group group;

  List<String> voucherType = [
    '1Voucher',
    'Blue Voucher',
    'Easy Load',
    'Easy Pay',
    'OTT',
  ];

  ActivationRequestWidget({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        'Join Next Competions',
        style: TextStyle(
          fontSize: MyApplication.infoTextFontSize,
          color: MyApplication.attractiveColor1,
        ),
      ),
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 20,
        color: MyApplication.logoColor2,
        onPressed: (() {
          Get.back();
        }),
      ),
      elevation: 0,
    ),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.black),
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
            // Group Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: findFullURL(group.groupCreatorImageURL),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          /*return CircleAvatar(
                                radius: MediaQuery.of(context).size.width * 0.09,
                                backgroundColor: backgroundResourcesColor,
                                backgroundImage:
                                    NetworkImage(snapshot.data as String),
                              ); */
                          return CachedNetworkImage(
                            key: UniqueKey(),
                            fit: BoxFit.cover,
                            imageUrl: snapshot.data as String,
                            fadeOutCurve: Curves.easeOutExpo,
                            imageBuilder: (c, provider) {
                              return CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.09,
                                backgroundColor: backgroundResourcesColor,
                                backgroundImage: NetworkImage(
                                  snapshot.data as String,
                                ),
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
                          return getCircularProgressBar();
                        } else {
                          return getCircularProgressBar();
                        }
                      }),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '@${group.groupCreatorUsername} [${group.groupName}]',
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: MyApplication.logoColor2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            group.groupSpecificArea!,
                            style: TextStyle(
                              fontSize: 16,
                              color: MyApplication.logoColor1,
                              decoration: TextDecoration.none,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            Converter.asString(group.groupArea.sectionName),
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: MyApplication.attractiveColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Voucher Type
            GetBuilder<GroupController>(
              builder: (_) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              voucherType[0],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: MyApplication.storesTextColor,
                              ),
                            ),
                            value: voucherType[0],
                            groupValue: Converter.toVoucherAsString(
                              groupController.newActivationRequestVoucherType,
                            ),
                            onChanged: (newValue) {
                              groupController
                                  .setNewActivationRequestVoucherType(
                                    newValue as String,
                                  );
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              voucherType[4],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: MyApplication.storesTextColor,
                              ),
                            ),
                            value: voucherType[4],
                            groupValue: Converter.toVoucherAsString(
                              groupController.newActivationRequestVoucherType,
                            ),
                            onChanged: (newValue) {
                              groupController
                                  .setNewActivationRequestVoucherType(
                                    newValue as String,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              voucherType[2],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: MyApplication.storesTextColor,
                              ),
                            ),
                            value: voucherType[2],
                            groupValue: Converter.toVoucherAsString(
                              groupController.newActivationRequestVoucherType,
                            ),
                            onChanged: (newValue) {
                              groupController
                                  .setNewActivationRequestVoucherType(
                                    newValue as String,
                                  );
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text(
                              voucherType[3],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: MyApplication.storesTextColor,
                              ),
                            ),
                            value: voucherType[3],
                            groupValue: Converter.toVoucherAsString(
                              groupController.newActivationRequestVoucherType,
                            ),
                            onChanged: (newValue) {
                              groupController
                                  .setNewActivationRequestVoucherType(
                                    newValue as String,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                    RadioListTile(
                      title: Text(
                        voucherType[1],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyApplication.storesTextColor,
                        ),
                      ),
                      value: voucherType[1],
                      groupValue: Converter.toVoucherAsString(
                        groupController.newActivationRequestVoucherType,
                      ),
                      onChanged: (newValue) {
                        groupController.setNewActivationRequestVoucherType(
                          newValue as String,
                        );
                      },
                    ),
                  ],
                );
              },
            ),

            // Voucher Pin Textfield & Proceed Button
            Column(
              children: [
                // Voucher Pin Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    minLines: 1,
                    maxLength: 17,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: MyApplication.logoColor1),
                    cursorColor: MyApplication.logoColor1,
                    controller: voucherCodeEditingController,
                    decoration: InputDecoration(
                      labelText: 'Voucher',
                      prefixIcon: Icon(
                        Icons.pin,
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
                  ),
                ),

                // Proceed Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: proceedButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget proceedButton() => Builder(
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: MyApplication.logoColor1,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () async {
            groupController.setShowProgressIndicator(true);
            Future<ActivationRequestSavingStatus>
            activationRequestSavingStatus = groupController
                .saveActivationRequest(voucherCodeEditingController.text);
            groupController.setShowProgressIndicator(false);

            activationRequestSavingStatus.then((status) {
              if (status == ActivationRequestSavingStatus.voucherNotProvided) {
                getSnapbar('Error', 'Voucher Not Provided.');
              } else if (status ==
                  ActivationRequestSavingStatus.voucherInvalid) {
                getSnapbar('Error', 'Voucher Is Not Valid.');
              } else if (status ==
                  ActivationRequestSavingStatus.groupNotSpecified) {
                getSnapbar('Error', 'Group Not Picked.');
              } else {
                getSnapbar('Sent', 'Voucher Sent Successfully.');
                groupController.setNewActivationRequestVoucherGroupId(null);
                groupController
                    .setNewActivationRequestVoucherGroupCreatorImageURL(null);
                Get.close(1);
              }
            });
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
    },
  );
}
