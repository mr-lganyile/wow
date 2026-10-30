import '../../screens/utils/start_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';
import '../../controllers/group_controller.dart';
import '../../main.dart';
import '../../models/converter.dart';
import '../../models/locations/supported_area.dart';

import 'dart:developer' as debug;
import '../utils/globals.dart';
import 'single_member_form_widget.dart';

class GroupRegistrationWidget extends StatelessWidget {
  TextEditingController groupNameEditingController = TextEditingController();

  TextEditingController groupSpecificAreaEditingController =
      TextEditingController();

  TextEditingController leaderUsernameEditingController =
      TextEditingController();
  TextEditingController leaderPhoneNumberEditingController =
      TextEditingController();

  TextEditingController username1EditingController = TextEditingController();
  TextEditingController phoneNumber1EditingController = TextEditingController();

  TextEditingController username2EditingController = TextEditingController();
  TextEditingController phoneNumber2EditingController = TextEditingController();

  TextEditingController username3EditingController = TextEditingController();
  TextEditingController phoneNumber3EditingController = TextEditingController();

  TextEditingController username4EditingController = TextEditingController();
  TextEditingController phoneNumber4EditingController = TextEditingController();

  GroupController groupController = GroupController.instance;

  late Stream<List<SupportedArea>> supportedAreasStream = locationController
      .readAllSupportedAreas();
  late List<String> items;
  LocationController locationController = LocationController.locationController;
  late DropdownButton2<String> dropDowButton;

  GroupRegistrationWidget() {
    groupController.clearAll();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        'Registration',
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
    body: Container(color: Colors.black, child: buildRecruit(context)),
  );

  bool isValidInputWithoutImages() {
    bool hasGroup =
        groupNameEditingController.text.isNotEmpty &&
        dropDowButton.value != null &&
        groupSpecificAreaEditingController.text.isNotEmpty;

    if (hasGroup == false) {
      return false;
    }

    if (hasUserWithoutImages(0) &&
        hasUserWithoutImages(1) &&
        hasUserWithoutImages(2) &&
        hasUserWithoutImages(3) &&
        hasUserWithoutImages(4)) {
      return true;
    }

    if (hasUserWithoutImages(0) &&
        hasUserWithoutImages(1) &&
        hasUserWithoutImages(2) &&
        hasUserWithoutImages(3)) {
      return true;
    }

    if (hasUserWithoutImages(0) &&
        hasUserWithoutImages(1) &&
        hasUserWithoutImages(2)) {
      return true;
    }

    if (hasUserWithoutImages(0) && hasUserWithoutImages(1)) {
      return true;
    }

    if (hasUserWithoutImages(0)) {
      return true;
    }

    return false;
  }

  bool hasUserWithoutImages(int memberIndex) {
    switch (memberIndex) {
      case 1:
        return phoneNumber1EditingController.text.isNotEmpty &&
            username1EditingController.text.isNotEmpty;
      case 2:
        return phoneNumber2EditingController.text.isNotEmpty &&
            username2EditingController.text.isNotEmpty;
      case 3:
        return phoneNumber3EditingController.text.isNotEmpty &&
            username3EditingController.text.isNotEmpty;
      case 4:
        return phoneNumber4EditingController.text.isNotEmpty &&
            username4EditingController.text.isNotEmpty;
      default:
        return leaderPhoneNumberEditingController.text.isNotEmpty &&
            leaderUsernameEditingController.text.isNotEmpty;
    }
  }

  bool containsNumbersOnly(String phoneNumber) {
    for (var charIndex = 0; charIndex < phoneNumber.length; charIndex++) {
      if (!(phoneNumber[charIndex] == '0' ||
          phoneNumber[charIndex] == '1' ||
          phoneNumber[charIndex] == '2' ||
          phoneNumber[charIndex] == '3' ||
          phoneNumber[charIndex] == '4' ||
          phoneNumber[charIndex] == '5' ||
          phoneNumber[charIndex] == '6' ||
          phoneNumber[charIndex] == '7' ||
          phoneNumber[charIndex] == '8' ||
          phoneNumber[charIndex] == '9')) {
        return false;
      }
    }
    return true;
  }

  bool isValidPhoneNumber(int memberIndex) {
    switch (memberIndex) {
      case 1:
        return username1EditingController.text.length == 10 &&
            (username1EditingController.text.startsWith('06') ||
                username1EditingController.text.startsWith('07') ||
                username1EditingController.text.startsWith('08')) &&
            containsNumbersOnly(username1EditingController.text);
      case 2:
        return username2EditingController.text.length == 10 &&
            (username2EditingController.text.startsWith('06') ||
                username2EditingController.text.startsWith('07') ||
                username2EditingController.text.startsWith('08')) &&
            containsNumbersOnly(username2EditingController.text);
      case 3:
        return username3EditingController.text.length == 10 &&
            (username3EditingController.text.startsWith('06') ||
                username3EditingController.text.startsWith('07') ||
                username3EditingController.text.startsWith('08')) &&
            containsNumbersOnly(username3EditingController.text);
      case 4:
        return username4EditingController.text.length == 10 &&
            (username4EditingController.text.startsWith('06') ||
                username4EditingController.text.startsWith('07') ||
                username4EditingController.text.startsWith('08')) &&
            containsNumbersOnly(username4EditingController.text);
      default:
        return leaderPhoneNumberEditingController.text.length == 10 &&
            (leaderPhoneNumberEditingController.text.startsWith('06') ||
                leaderPhoneNumberEditingController.text.startsWith('07') ||
                leaderPhoneNumberEditingController.text.startsWith('08')) &&
            containsNumbersOnly(leaderPhoneNumberEditingController.text);
    }
  }

  Widget buildRecruit(BuildContext context) {
    // Invoked so that we set captured image locations using the document id.
    groupController.setGroupDocumentReference();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Logo
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/logo.png')),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Alco',
              style: TextStyle(
                fontSize: MyApplication.infoTextFontSize,
                color: MyApplication.logoColor1,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Group Area Name
            GetBuilder<GroupController>(
              builder: (_) {
                return StreamBuilder<List<SupportedArea>>(
                  stream: supportedAreasStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<String> dbItems = [];

                      for (
                        int areaIndex = 0;
                        areaIndex < snapshot.data!.length;
                        areaIndex++
                      ) {
                        dbItems.add(snapshot.data![areaIndex].toString());
                      }
                      items = dbItems;
                      items.sort();
                      return pickAreaName(context);
                    } else if (snapshot.hasError) {
                      debug.log(
                        "Error Fetching Supported Areas Data - ${snapshot.error}",
                      );
                      return getCircularProgressBar();
                    } else {
                      return getCircularProgressBar();
                    }
                  },
                );
              },
            ),

            const SizedBox(height: 10),

            // Group Members
            SingleMemberFormWidget(
              userNameController: leaderUsernameEditingController,
              phoneNumberController: leaderPhoneNumberEditingController,
              memberIndex: 0,
            ),
            // Group Name
            userSpecificLocationOrGroupName(false),

            const SizedBox(height: 10),

            // Group Specific Area
            userSpecificLocationOrGroupName(true),

            const SizedBox(height: 10),

            // Group Image
            groupPicking(context),

            const SizedBox(height: 10),

            SingleMemberFormWidget(
              userNameController: username1EditingController,
              phoneNumberController: phoneNumber1EditingController,
              memberIndex: 1,
            ),
            SingleMemberFormWidget(
              userNameController: username2EditingController,
              phoneNumberController: phoneNumber2EditingController,
              memberIndex: 2,
            ),
            /*
            SingleMemberFormWidget(
              userNameController: username3EditingController,
              phoneNumberController: phoneNumber3EditingController,
              memberIndex: 3,
            ),
            SingleMemberFormWidget(
              userNameController: username4EditingController,
              phoneNumberController: phoneNumber4EditingController,
              memberIndex: 4,
            ),
            */
            GetBuilder<GroupController>(
              builder: (_) {
                return groupController.showProgressBar
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyApplication.logoColor2,
                        ),
                      )
                    : createGroupButton(context);
              },
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  AspectRatio retrieveGroupImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: GetBuilder<GroupController>(
        builder: (_) {
          return groupController.groupImageURL!.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: MyApplication.logoColor1,
                  ),
                  child: const Text(
                    'Group Image Area',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              : /*Container(
                    //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
                    decoration: BoxDecoration(
                      color: backgroundResourcesColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(groupController.groupImageURL!),
                      ),
                    ),
                  ); */ CachedNetworkImage(
                  key: UniqueKey(),
                  fit: BoxFit.cover,
                  imageUrl: groupController.groupImageURL!,
                  fadeOutCurve: Curves.easeOutExpo,
                  imageBuilder: (c, provider) {
                    return Container(
                      //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
                      decoration: BoxDecoration(
                        color: backgroundResourcesColor,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: provider,
                        ),
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
        },
      ),
    );
  }

  Widget groupPicking(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: retrieveGroupImage(context)),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              IconButton(
                color: Colors.white,
                iconSize: MediaQuery.of(context).size.width * 0.15,
                icon: Icon(Icons.camera_alt, color: MyApplication.logoColor1),
                onPressed: () async {
                  groupController.captureGroupImageWithCamera(
                    groupNameEditingController.text,
                    Converter.toSectionName(dropDowButton.value!),
                    groupSpecificAreaEditingController.text,
                  );
                },
              ),
              IconButton(
                color: Colors.white,
                iconSize: MediaQuery.of(context).size.width * 0.15,
                icon: Icon(Icons.upload, color: MyApplication.logoColor1),
                onPressed: () async {
                  groupController.chooseGroupImageFromGallery(
                    groupNameEditingController.text,
                    Converter.toSectionName(dropDowButton.value!),
                    groupSpecificAreaEditingController.text,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget createGroupButton(BuildContext context) => Container(
    width: MediaQuery.of(context).size.width,
    height: 45,
    decoration: BoxDecoration(
      color: MyApplication.logoColor1,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: InkWell(
      onTap: () async {
        if (groupSpecificAreaEditingController.text.isEmpty) {
          getSnapbar(
            'Group Registration Error',
            'Group Specific Area Not Entered.',
          );
        } else if (leaderPhoneNumberEditingController.text.isEmpty) {
          getSnapbar(
            'Group Registration Error',
            'Leader Phone Number Not Entered.',
          );
        } else if (leaderPhoneNumberEditingController.text.length != 10) {
          getSnapbar(
            'Group Registration Error',
            'Invalid Leader Phone Number.',
          );
        } else if (leaderUsernameEditingController.text.isEmpty) {
          getSnapbar(
            'Group Registration Error',
            'Leader Username Not Entered.',
          );
        } else if (groupController.leaderImageURL.isEmpty ||
            groupController.leaderProfileImageFile == null) {
          getSnapbar(
            'Group Registration Error',
            'Leader Profile Image Not Entered.',
          );
        } else if (phoneNumber1EditingController.text.isNotEmpty &&
            phoneNumber1EditingController.text.length != 10) {
          getSnapbar(
            'Group Registration Error',
            'Invalid Member1 Phone Number.',
          );
        } else if (phoneNumber1EditingController.text.isNotEmpty &&
            username1EditingController.text.isEmpty) {
          getSnapbar(
            'Group Registration Error',
            'Member1 Username Not Entered.',
          );
        } else if (phoneNumber1EditingController.text.isNotEmpty &&
            (groupController.member1ImageURL.isEmpty ||
                groupController.member1ProfileImageFile == null)) {
          getSnapbar('Group Registration Error', 'Member1 Image Not Entered.');
        } else if (phoneNumber2EditingController.text.isNotEmpty &&
            phoneNumber2EditingController.text.length != 10) {
          getSnapbar(
            'Group Registration Error',
            'Invalid Member2 Phone Number.',
          );
        } else if (phoneNumber2EditingController.text.isNotEmpty &&
            username2EditingController.text.isEmpty) {
          getSnapbar(
            'Group Registration Error',
            'Member2 Username Not Entered.',
          );
        } else if (phoneNumber2EditingController.text.isNotEmpty &&
            (groupController.member2ImageURL.isEmpty ||
                groupController.member2ProfileImageFile == null)) {
          getSnapbar('Group Registration Error', 'Member2 Image Not Entered.');
        } else {
          groupController.setShowProgressIndicator(true);
          //if (isLeaderValidated) {
          debug.log('About to save a group');
          final result = await groupController.createGroup();

          // It takes time to go to the next page.
          if (result == GroupSavingStatus.saved) {
            groupController.setShowProgressIndicator(false);
            Get.to(() => StartScreen());
          }
          /*} else {
                final auth = FirebaseAuth.instance;

                await auth.verifyPhoneNumber(
                  phoneNumber: groupController.leaderPhoneNumber,
                  verificationCompleted:
                      (PhoneAuthCredential credential) async {
                    debug.log(
                        '1. About To Signed In User From GroupRegistrationScreen...');
                    // ANDROID ONLY!
                    // Sign the user in (or link) with the auto-generated credential
                    await auth.signInWithCredential(credential);
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    if (e.code == 'invalid-phone-number') {
                      debug.log('The provided phone number is not valid.');
                    }

                    // Handle other errors
                  },
                  codeSent: (String verificationId, int? resendToken) async {
                    Get.to(() => GroupVerificationWidget(
                          verificationId: verificationId,
                        ));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              } */
        }
      },
      child: const Center(
        child: Text(
          'Create Group',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  Widget pickAreaName(BuildContext context) {
    dropDowButton = DropdownButton2<String>(
      isExpanded: true,
      hint: Row(
        children: [
          Icon(
            Icons.location_searching,
            size: 22,
            color: MyApplication.logoColor1,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              'Group Township',
              style: TextStyle(fontSize: 14, color: MyApplication.logoColor2),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: items
          .map(
            (String item) => DropdownMenuItem<String>(
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
            ),
          )
          .toList(),
      value: Converter.asString(groupController.groupSupportedArea.sectionName),
      onChanged: (String? value) {
        groupController.setSupportedArea(value!);
        groupController.setHasPickedGroupArea(true);
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

  Widget userSpecificLocationOrGroupName(bool forSpecificArea) => TextField(
    style: TextStyle(color: MyApplication.logoColor1),
    cursorColor: MyApplication.logoColor1,
    controller: forSpecificArea
        ? groupSpecificAreaEditingController
        : groupNameEditingController,
    decoration: InputDecoration(
      labelText: forSpecificArea ? 'Group Specific Area' : 'Group Name',
      prefixIcon: Icon(
        forSpecificArea ? Icons.location_city : Icons.group,
        color: MyApplication.logoColor1,
      ),
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
