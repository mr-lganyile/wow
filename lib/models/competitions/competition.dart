import '../converter.dart';
import '../locations/supported_town_or_institution.dart';
import '/models/hosting areas/draw_grand_price.dart';

import '../users/group.dart';
import 'competition_state.dart';

// Collection Name /competition/competitionId
// Branch : competition_resources_crud ->  create_competition_resources_front_end
class Competition {
  String? competitionId;
  String hostingAreaFK;

  bool isLive;
  bool isOver;
  int joiningFee;

  SupportedTownOrInstitution competitionTownOrInstitution;

  DateTime dateTime;
  int pickingMultipleInSeconds;

  String? grandPricesGridId;
  List<int> grandPricesOrder;
  int numberOfGrandPrices;

  String? competitorsGridId;
  List<String> competitorsOrder;
  int groupPickingStartTime;

  int? timeBetweenPricePickingAndGroupPicking;
  int? displayPeriodAfterWinners;

  bool? isWonGrandPricePicked;
  bool? isWonCompetitorGroupPicked;

  CompetitionState? competitionState;

  DrawGrandPrice? wonPrice;
  Group? wonGroup;

  Competition({
    this.competitionId,
    required this.hostingAreaFK,
    required this.competitionTownOrInstitution,
    this.isLive = false,
    required this.dateTime,
    required this.joiningFee,
    this.isOver = false,
    required this.grandPricesOrder,
    this.isWonGrandPricePicked = false,
    this.grandPricesGridId,
    required this.numberOfGrandPrices,
    required this.competitorsOrder,
    this.isWonCompetitorGroupPicked = false,
    this.competitorsGridId,
    required this.pickingMultipleInSeconds,
    this.timeBetweenPricePickingAndGroupPicking = 5,
    required this.groupPickingStartTime,
    this.displayPeriodAfterWinners = 30,
    this.competitionState,
    this.wonGroup,
    this.wonPrice,
  });

  factory Competition.fromJson(dynamic json) {
    List<int> grandPricesOrder =
        convertGrandPricesOrder(json["grandPricesOrder"]);
    List<String> competitorsOrder =
        convertCompetitorsOrder(json['competitorsOrder']);
    int pickingMultipleInSeconds = json['pickingMultipleInSeconds'];
    int timeBetweenPricePickingAndGroupPicking =
        json["timeBetweenPricePickingAndGroupPicking"];

    return Competition(
        wonPrice: json['wonPrice'] != null
            ? DrawGrandPrice.fromJson(json['wonPrice'])
            : null,
        wonGroup:
            json['wonGroup'] != null ? Group.fromJson(json['wonGroup']) : null,
        pickingMultipleInSeconds: pickingMultipleInSeconds,
        timeBetweenPricePickingAndGroupPicking:
            timeBetweenPricePickingAndGroupPicking,
        groupPickingStartTime: json['groupPickingStartTime'],
        displayPeriodAfterWinners: json['displayPeriodAfterWinners'],
        competitionId: json['competitionId'],
        hostingAreaFK: json['hostingAreaFK'],
        competitionTownOrInstitution: SupportedTownOrInstitution.fromJson(
            json['competitionTownOrInstitution']),
        isLive: json['isLive'],
        dateTime: DateTime(
          json['dateTime']['year'],
          json['dateTime']['month'],
          json['dateTime']['day'],
          json['dateTime']['hour'],
          json['dateTime']['minute'],
        ),
        joiningFee: json['joiningFee'],
        isOver: json['isOver'],
        grandPricesOrder: grandPricesOrder,
        isWonGrandPricePicked: json['isWonGrandPricePicked'],
        grandPricesGridId: json['grandPricesGridId'],
        numberOfGrandPrices: json["numberOfGrandPrices"],
        competitorsOrder: competitorsOrder,
        isWonCompetitorGroupPicked: json['isWonCompetitorGroupPicked'],
        competitorsGridId: json['competitorsGridId'],
        competitionState:
            Converter.toCompetitionState(json['competitionState']));
  }

  void setIsOver(bool isOver) {
    this.isOver = isOver;
  }

  void setIsWonPricePicked(bool isWonCompetitorGroupPicked) {
    this.isWonCompetitorGroupPicked = isWonCompetitorGroupPicked;
  }

  static List<int> convertGrandPricesOrder(List<dynamic> order) {
    List<int> list = [];

    for (int i = 0; i < order.length; i++) {
      list.add(order[i]);
    }

    return list;
  }

  static List<String> convertCompetitorsOrder(List<dynamic> order) {
    List<String> list = [];

    for (int i = 0; i < order.length; i++) {
      list.add(order[i]);
    }

    return list;
  }
}
