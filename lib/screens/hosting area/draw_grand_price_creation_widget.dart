import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/group_controller.dart';
import '../../controllers/hosting_area_controller.dart';
import '../../main.dart';

import 'dart:developer' as debug;

import '../utils/globals.dart';

class DrawGrandPriceCreationWidget extends StatefulWidget {
  TextEditingController descriptionController;
  int grandPriceIndex;

  DrawGrandPriceCreationWidget({
    required this.descriptionController,
    required this.grandPriceIndex,
  });

  @override
  State createState() => DrawGrandPriceCreationWidgetState();
}

class DrawGrandPriceCreationWidgetState
    extends State<DrawGrandPriceCreationWidget> {
  GroupController groupController = GroupController.instance;
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  DrawGrandPriceCreationWidgetState();

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            showPickedPrice(),
            const SizedBox(
              height: 10,
            ),
            singlePricePicker(),
            const SizedBox(
              height: 10,
            ),
            TextField(
              minLines: 1,
              maxLines: 10,
              style: TextStyle(color: MyApplication.logoColor1),
              cursorColor: MyApplication.logoColor1,
              controller: widget.descriptionController,
              decoration: InputDecoration(
                labelText: 'Description ${widget.grandPriceIndex + 1}',
                /*prefixIcon:
                    Icon(Icons.description, color: MyApplication.logoColor1),*/
                labelStyle: TextStyle(
                  fontSize: 14,
                  color: MyApplication.logoColor2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: MyApplication.logoColor2,
                  ),
                ),
              ),
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );

  Widget showPickedPrice() {
    switch (widget.grandPriceIndex) {
      case 0:
        return GetBuilder<HostingAreaController>(builder: (_) {
          return hostingAreaController.grandPrice1ImageURL!.isEmpty ||
                  hostingAreaController.drawGrandPrice1ImageFile == null
              ? const SizedBox.shrink()
              : Center(
                  /*child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: backgroundResourcesColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            NetworkImage(hostingAreaController.grandPrice1ImageURL!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), */
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: hostingAreaController.grandPrice1ImageURL!,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: backgroundResourcesColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
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
                  ),
                );
        });
      case 1:
        return GetBuilder<HostingAreaController>(builder: (_) {
          return hostingAreaController.grandPrice2ImageURL!.isEmpty ||
                  hostingAreaController.drawGrandPrice2ImageFile == null
              ? const SizedBox.shrink()
              : Center(
                  /*child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: backgroundResourcesColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            NetworkImage(hostingAreaController.grandPrice2ImageURL!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), */
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: hostingAreaController.grandPrice2ImageURL!,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: backgroundResourcesColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
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
                  ),
                );
        });
      case 2:
        return GetBuilder<HostingAreaController>(builder: (_) {
          return hostingAreaController.grandPrice3ImageURL!.isEmpty ||
                  hostingAreaController.drawGrandPrice3ImageFile == null
              ? const SizedBox.shrink()
              : Center(
                  /*child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: backgroundResourcesColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            NetworkImage(hostingAreaController.grandPrice3ImageURL!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), */
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: hostingAreaController.grandPrice3ImageURL!,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: backgroundResourcesColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
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
                  ),
                );
        });
      case 3:
        return GetBuilder<HostingAreaController>(builder: (_) {
          return hostingAreaController.grandPrice4ImageURL!.isEmpty ||
                  hostingAreaController.drawGrandPrice4ImageFile == null
              ? const SizedBox.shrink()
              : Center(
                  /*child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: backgroundResourcesColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            NetworkImage(hostingAreaController.grandPrice4ImageURL!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), */
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: hostingAreaController.grandPrice4ImageURL!,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: backgroundResourcesColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
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
                  ),
                );
        });
      default:
        return GetBuilder<HostingAreaController>(builder: (_) {
          return hostingAreaController.grandPrice5ImageURL!.isEmpty ||
                  hostingAreaController.drawGrandPrice5ImageFile == null
              ? const SizedBox.shrink()
              : Center(
                  /* child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: backgroundResourcesColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            NetworkImage(hostingAreaController.grandPrice5ImageURL!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), */
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                    imageUrl: hostingAreaController.grandPrice5ImageURL!,
                    fadeOutCurve: Curves.easeOutExpo,
                    imageBuilder: (c, provider) {
                      return Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: backgroundResourcesColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
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
                  ),
                );
        });
    }
  }

  Widget singlePricePicker() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Download Icon
          Expanded(
            child: IconButton(
              color: Colors.white,
              iconSize: MediaQuery.of(context).size.width * 0.15,
              icon: Icon(Icons.download, color: MyApplication.logoColor1),
              onPressed: () async {
                debug.log(
                    'drawGrandPrice Index ${widget.grandPriceIndex} Description ${widget.descriptionController.text}');
              },
            ),
          ),
          // Camera Icon
          Expanded(
            child: IconButton(
              color: Colors.white,
              iconSize: MediaQuery.of(context).size.width * 0.15,
              icon: Icon(Icons.camera_alt, color: MyApplication.logoColor2),
              onPressed: () async {
                hostingAreaController.captureGrandPriceImageFromCamera(
                  widget.grandPriceIndex,
                );
              },
            ),
          ),
          // Upload Icon
          Expanded(
            child: IconButton(
                color: Colors.white,
                iconSize: MediaQuery.of(context).size.width * 0.15,
                icon: Icon(Icons.upload, color: MyApplication.logoColor1),
                onPressed: () async {
                  hostingAreaController.chooseGrandPriceImageFromGallery(
                    widget.grandPriceIndex,
                  );
                }),
          ),
        ],
      );
}
