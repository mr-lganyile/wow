import 'package:cached_network_image/cached_network_image.dart';

import '../../controllers/hosting_area_controller.dart';
import '../../models/converter.dart';
import '../../models/hosting areas/hosted_draw.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/locations/section_name.dart';

import 'dart:developer' as debug;

import '../utils/globals.dart';

// Branch : store_resources_crud ->  view_stores_front_end
class HostingAreaWidget extends StatefulWidget {
  String hostingAreaName;
  String hostingAreaId;
  String hostingAreaImageURL;
  SectionName sectionName;

  HostingAreaWidget({
    super.key,
    required this.hostingAreaId,
    required this.hostingAreaName,
    required this.hostingAreaImageURL,
    required this.sectionName,
  });

  Column retrieveHostingAreaDetails(BuildContext context) {
    // Information About The Hosting Store.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The Name Of A Store On Which The Winner Won From.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Host Area Name',
                style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    color: MyApplication.storeInfoTextColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  hostingAreaName,
                  style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storeInfoTextColor,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),

        // The Location Of A Store On Which The Winner Won From.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Host Home',
                style: TextStyle(
                    fontSize: MyApplication.infoTextFontSize,
                    fontWeight: FontWeight.bold,
                    color: MyApplication.storeInfoTextColor,
                    decoration: TextDecoration.none),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  Converter.asString(sectionName),
                  style: TextStyle(
                      fontSize: MyApplication.infoTextFontSize,
                      fontWeight: FontWeight.bold,
                      color: MyApplication.storeInfoTextColor,
                      decoration: TextDecoration.none,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  AspectRatio retrieveHostingAreaImage(
      BuildContext context, String storeImage) {
    debug.log('host info widget retrieveHostingAreaImage...');
    // The Image Of A Store On Which The Winner Won From.
    return AspectRatio(
      aspectRatio: 5 / 2,
      /* child: Container(
        //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
        decoration: BoxDecoration(
          color: backgroundResourcesColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(storeImage)),
        ),
      ), */
      child: CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        imageUrl: storeImage,
        fadeOutCurve: Curves.easeOutExpo,
        imageBuilder: (c, provider) {
          return Container(
            //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
            decoration: BoxDecoration(
              color: backgroundResourcesColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(fit: BoxFit.cover, image: provider),
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
  }

  Future<String> createHostingAreaImageURL() {
    return reference.child(hostingAreaImageURL).getDownloadURL();
  }

  @override
  State<StatefulWidget> createState() => HostingAreaWidgetState();
}

class HostingAreaWidgetState extends State<HostingAreaWidget> {
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;
  late List<HostedDraw> hostedDraws;

  @override
  void initState() {
    super.initState();
    hostedDraws = hostingAreaController.findHostedDraws(widget.hostingAreaId)
        as List<HostedDraw>;
  }

  int findSpecialDateIndex() {
    DateTime now = DateTime.now();

    for (int i = 0; i < hostedDraws.length; i++) {
      if (hostedDraws[i].drawDateAndTime.year == now.year &&
          hostedDraws[i].drawDateAndTime.month == now.month &&
          hostedDraws[i].drawDateAndTime.day == now.day) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.createHostingAreaImageURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                SizedBox(
                    height: 150,
                    child: widget.retrieveHostingAreaImage(
                        context, snapshot.data as String)),
                SizedBox(
                  height: 50,
                  child: widget.retrieveHostingAreaDetails(context),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            debug.log('Error Fetching Hosting Area Image - ${snapshot.error}');
            return getCircularProgressBar();
          } else {
            return getCircularProgressBar();
          }
        });
  }
}
