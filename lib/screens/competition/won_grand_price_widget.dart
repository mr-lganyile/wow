import 'package:cached_network_image/cached_network_image.dart';

import '/models/hosting areas/draw_grand_price.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

import 'dart:developer' as debug;

import '../utils/globals.dart';

class WonGrandPriceWidget extends StatelessWidget {
  DrawGrandPrice wonPrice;

  WonGrandPriceWidget({
    required this.wonPrice,
  });

  Future<String> findWonPriceImageURL() async {
    return reference.child(wonPrice.imageURL).getDownloadURL();
  }

  String trimImageURL(String imageURL) {
    String newURL = imageURL.replaceFirst('%40', '@');
    newURL = newURL.replaceFirst('%3A', ':');

    return newURL;
  }

  AspectRatio retrieveWonPriceImage(BuildContext context, String imageURL) {
    return AspectRatio(
      aspectRatio: 7 / 3,
      /* child: Container(
        decoration: BoxDecoration(
          color: backgroundResourcesColor,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(trimImageURL(imageURL)),
            //image: NetworkImage(store.picPath + store.picName)
          ),
        ),
      ), */
      child: CachedNetworkImage(
        key: UniqueKey(),
        fit: BoxFit.cover,
        imageUrl: trimImageURL(imageURL),
        fadeOutCurve: Curves.easeOutExpo,
        imageBuilder: (c, provider) {
          return Container(
            decoration: BoxDecoration(
              color: backgroundResourcesColor,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(trimImageURL(imageURL)),
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: findWonPriceImageURL(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return retrieveWonPriceImage(context, snapshot.data as String);
              } else if (snapshot.hasError) {
                debug.log(
                    'Error Fetching Won Grand Price Image - ${snapshot.error}');
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            }),
        Text(
          wonPrice.description,
          style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              fontWeight: FontWeight.bold,
              color: MyApplication.logoColor1,
              decoration: TextDecoration.none),
        )
      ],
    );
  }
}
