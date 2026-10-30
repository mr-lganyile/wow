import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/group_controller.dart';
import '../../main.dart';
import '../utils/globals.dart';
import '../utils/single_member_text_field.dart';

import 'dart:developer' as debug;

// Branch : group_resources_crud ->  create_group_resources_front_end
class SingleMemberFormWidget extends StatefulWidget {
  TextEditingController userNameController;
  TextEditingController phoneNumberController;
  int memberIndex;

  SingleMemberFormWidget({
    required this.userNameController,
    required this.phoneNumberController,
    required this.memberIndex,
  });

  @override
  State<StatefulWidget> createState() => SingleMemberFormWidgetState();
}

class SingleMemberFormWidgetState extends State<SingleMemberFormWidget> {
  GroupController groupController = GroupController.instance;

  String labelText1 = 'Leader Username';
  String labelText2 = 'Leader Phone Number';

  void setLabels() {
    if (widget.memberIndex > 0) {
      labelText1 = 'Member ${widget.memberIndex} Username';
      labelText2 = 'Member ${widget.memberIndex} Phone Number';
    }
  }

  @override
  void initState() {
    super.initState();
    setLabels();
  }

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 5),
    child: Column(
      children: [
        SingleMemberTextField(
          controller: widget.userNameController,
          labelText: labelText1,
          memberIndex: widget.memberIndex,
        ),
        const SizedBox(height: 5),
        SingleMemberTextField(
          controller: widget.phoneNumberController,
          labelText: labelText2,
          memberIndex: widget.memberIndex,
          isForUserName: false,
        ),
        const SizedBox(height: 5),
        pickedMemberImage(),
        const SizedBox(height: 5),
        singleUserImagePicker(),
      ],
    ),
  );

  Widget singleUserImagePicker() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Upload Icon
      Expanded(
        child: IconButton(
          color: Colors.white,
          iconSize: MediaQuery.of(context).size.width * 0.15,
          icon: Icon(Icons.upload, color: MyApplication.logoColor1),
          onPressed: () async {
            groupController.chooseMemberProfileImageFromGallery(
              widget.memberIndex,
              widget.phoneNumberController.text,
              widget.userNameController.text,
            );

            debug.log(
              'Member Index ${widget.memberIndex} Phone No ${widget.phoneNumberController.text}',
            );
          },
        ),
      ),
      // 'Or' Icons Seperator
      Expanded(
        child: Center(
          child: Text(
            'Or',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: MyApplication.attractiveColor1,
            ),
          ),
        ),
      ),
      // Camera Icon
      Expanded(
        child: IconButton(
          color: Colors.white,
          iconSize: MediaQuery.of(context).size.width * 0.15,
          icon: Icon(Icons.camera_alt, color: MyApplication.logoColor1),
          onPressed: () async {
            groupController.captureMemberProfileImageFromCamera(
              widget.memberIndex,
              widget.phoneNumberController.text,
              widget.userNameController.text,
            );
          },
        ),
      ),
    ],
  );

  Widget pickedMemberImage() {
    switch (widget.memberIndex) {
      case 1:
        return GetBuilder<GroupController>(
          builder: (_) {
            return groupController.member1ImageURL.isEmpty
                ? const SizedBox.shrink()
                : /*CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                NetworkImage(groupController.member1ImageURL))),
                  ),
                ); */ CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: groupController.member1ImageURL,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: provider),
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
        );
      case 2:
        return GetBuilder<GroupController>(
          builder: (_) {
            return groupController.member2ImageURL.isEmpty
                ? const SizedBox.shrink()
                : /*CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                NetworkImage(groupController.member2ImageURL))),
                  ),
                ); */ CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: groupController.member2ImageURL,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: provider),
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
        );
      /*
      case 3:
        return GetBuilder<GroupController>(builder: (_) {
          return groupController.member3ImageURL.isEmpty
              ? const SizedBox.shrink()
              : /*CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                NetworkImage(groupController.member3ImageURL))),
                  ),
                ); */
              CachedNetworkImage(
                  key: UniqueKey(),
                  fit: BoxFit.cover,
                  imageUrl: groupController.member3ImageURL,
                  fadeOutCurve: Curves.easeOutExpo,
                  imageBuilder: (c, provider) {
                    return CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: provider),
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
        });
      case 4:
        return GetBuilder<GroupController>(builder: (_) {
          return groupController.member4ImageURL.isEmpty
              ? const SizedBox.shrink()
              : /*CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                NetworkImage(groupController.member4ImageURL))),
                  ),
                ); */
              CachedNetworkImage(
                  key: UniqueKey(),
                  fit: BoxFit.cover,
                  imageUrl: groupController.member4ImageURL,
                  fadeOutCurve: Curves.easeOutExpo,
                  imageBuilder: (c, provider) {
                    return CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 8,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: provider),
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
        });
        */
      default:
        return GetBuilder<GroupController>(
          builder: (_) {
            return groupController.leaderImageURL.isEmpty
                ? const SizedBox.shrink()
                : /*CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                NetworkImage(groupController.leaderImageURL))),
                  ),
                ); */ CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: groupController.leaderImageURL,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 8,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: provider),
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
        );
    }
  }
}
