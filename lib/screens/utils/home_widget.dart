import '/models/users/admin.dart';

import '../../models/converter.dart';
import '../../models/users/user.dart' as my;
import '../../models/users/abstract_user.dart';
import '/controllers/competition_controller.dart';

import '../../models/competitions/won_price_summary.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../competition/won_price_summary_widget.dart';

import 'dart:developer' as debug;

import 'globals.dart';

// Branch : won_price_summary_resources_crud -> view_won_price_summaries
class HomeWidget extends StatefulWidget {
  HomeWidget({super.key});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  CompetitionController competitionController =
      CompetitionController.competitionController;
  late Stream<List<WonPriceSummary>> wonPriceSummariesStream;
  _HomeWidgetState();

  @override
  void initState() {
    super.initState();

    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      wonPriceSummariesStream = competitionController.readAreaWonPriceSummaries(
        "5",
      ); // Mayville
    } else if (user is my.User) {
      wonPriceSummariesStream = competitionController.readAreaWonPriceSummaries(
        user.area.townOrInstitutionFK,
      );
    } else {
      wonPriceSummariesStream = competitionController.readAreaWonPriceSummaries(
        Converter.townOrInstitutionAsNumber((user as Admin).townOrInstitution)
            as String,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    height: 300,
    decoration: BoxDecoration(
      color: MyApplication.scaffoldColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: StreamBuilder<List<WonPriceSummary>>(
      stream: wonPriceSummariesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<WonPriceSummary> wonPrices = snapshot.data!;
          return ListView.builder(
            itemCount: wonPrices.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  WonPriceSummaryWidget(wonPriceSummary: wonPrices[index]),
                ],
              );
            }),
          );
        } else if (snapshot.hasError) {
          debug.log(
            "Error Fetching Won Price Summaries Data *** - ${snapshot.error}",
          );
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      },
    ),
  );
}
