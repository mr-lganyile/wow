import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../controllers/hosting_area_controller.dart';
import "dart:developer" as debug;

import '../utils/globals.dart';

// Branch : competition_resources_crud ->  view_competitions
class GrandPriceWidget extends StatefulWidget {
  String grandPriceImageURL;
  AlignmentGeometry? alignmentGeometry;
  bool isPointed;
  bool showBall;

  GrandPriceWidget({
    super.key,
    required this.grandPriceImageURL,
    this.alignmentGeometry = Alignment.centerLeft,
    this.showBall = false,
    this.isPointed = false,
  });

  @override
  GrandPriceWidgetState createState() => GrandPriceWidgetState();
}

class GrandPriceWidgetState extends State<GrandPriceWidget> {
  HostingAreaController hostingAreaController =
      HostingAreaController.hostingAreaController;

  Future<String> retrieveGrandPriceImageURL() {
    return reference.child(widget.grandPriceImageURL).getDownloadURL();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget showGrandPrice() {
    return FutureBuilder(
      future: retrieveGrandPriceImageURL(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            /*child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: backgroundResourcesColor,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(snapshot.data! as String),
                    fit: BoxFit.cover,
                  ),
                ),
              ), */
            child: CachedNetworkImage(
              key: UniqueKey(),
              fit: BoxFit.cover,
              imageUrl: snapshot.data as String,
              fadeOutCurve: Curves.easeOutExpo,
              imageBuilder: (c, provider) {
                return Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: backgroundResourcesColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: provider, fit: BoxFit.cover),
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
        } else if (snapshot.hasError) {
          debug.log(
            'Error Fetching Draw Grand Price Image - ${snapshot.error}',
          );
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => showGrandPrice();
}
