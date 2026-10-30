// Collection Name /stores/storeId/store_draws/storeDrawId
// Branch : competition_resources_crud ->  create_competition_resources_front_end

import '../locations/supported_town_or_institution.dart';
import 'hosted_draw_state.dart';

import '../converter.dart';

// Only the latest store draw of a given store can be updated in a way that reflects in front end.
class HostedDraw implements Comparable<HostedDraw> {
  String? hostedDrawId;
  String groupToWinId;
  String hostingAreaFK;
  DateTime drawDateAndTime;

  bool isOpen;
  int numberOfGrandPrices;
  String hostingAreaName;
  String hostingAreaImageURL;
  SupportedTownOrInstitution townOrInstitution;
  HostedDrawState? hostedDrawState;

  int joiningFee;
  int grandPriceToWinIndex;
  String groupToWinPhoneNumber;

  // Contains A Sub Collection Of Draw Grand Prices
  // Contains A Sub Collection Of Draw Competitors
  // 'timestamp': DateTime.now().millisecondsSinceEpoch,

  HostedDraw({
    this.hostedDrawId = '',
    required this.groupToWinId,
    required this.hostingAreaFK,
    required this.drawDateAndTime,
    this.isOpen = true,
    required this.numberOfGrandPrices,
    required this.hostingAreaName,
    required this.hostingAreaImageURL,
    required this.townOrInstitution,
    this.hostedDrawState = HostedDrawState.notConvertedToCompetition,
    this.joiningFee = 0,
    required this.grandPriceToWinIndex,
    required this.groupToWinPhoneNumber,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'hostedDrawId': hostedDrawId,
      'groupToWinId': groupToWinId,
      'hostingAreaFK': hostingAreaFK,
      'drawDateAndTime': {
        'year': drawDateAndTime.year,
        'month': drawDateAndTime.month,
        'day': drawDateAndTime.day,
        'hour': drawDateAndTime.hour,
        'minute': drawDateAndTime.minute,
      },
      'numberOfGrandPrices': numberOfGrandPrices,
      'isOpen': isOpen,
      'hostingAreaName': hostingAreaName,
      'hostingAreaImageURL': hostingAreaImageURL,
      'townOrInstitution': townOrInstitution.toJson(),
      'joiningFee': joiningFee,
      'hostedDrawState': Converter.fromHostedDrawStateToString(
        hostedDrawState!,
      ),
      'grandPriceToWinIndex': grandPriceToWinIndex,
      'groupToWinPhoneNumber': groupToWinPhoneNumber,
    });
    return map;
  }

  factory HostedDraw.fromJson(dynamic json) => HostedDraw(
    hostedDrawId: json['hostedDrawId'],
    groupToWinId: json['groupToWinId'],
    hostingAreaFK: json['hostingAreaFK'],
    drawDateAndTime: DateTime(
      json['drawDateAndTime']['year'],
      json['drawDateAndTime']['month'],
      json['drawDateAndTime']['day'],
      json['drawDateAndTime']['hour'],
      json['drawDateAndTime']['minute'],
    ),
    numberOfGrandPrices: json['numberOfGrandPrices'],
    isOpen: json['isOpen'],
    hostingAreaName: json['hostingAreaName'],
    hostingAreaImageURL: json['hostingAreaImageURL'],
    grandPriceToWinIndex: json['grandPriceToWinIndex'],
    groupToWinPhoneNumber: json['groupToWinPhoneNumber'],
    townOrInstitution: SupportedTownOrInstitution.fromJson(
      json['townOrInstitution'],
    ),
    hostedDrawState: Converter.toHostedDrawState(json['hostedDrawState']),
  );

  @override
  int compareTo(HostedDraw other) {
    return other.drawDateAndTime.compareTo(drawDateAndTime);
  }

  String startOnDay() {
    String dateAndTime = '';

    if (drawDateAndTime.day < 10) {
      dateAndTime += '0${drawDateAndTime.day}';
    } else {
      dateAndTime += '${drawDateAndTime.day}';
    }

    dateAndTime += '-';

    if (drawDateAndTime.month < 10) {
      dateAndTime += '0${drawDateAndTime.month}';
    } else {
      dateAndTime += '${drawDateAndTime.month}';
    }

    dateAndTime += '-';
    dateAndTime += '${drawDateAndTime.year}';

    return dateAndTime;
  }

  String startOnTime() {
    String dateAndTime = '@';

    if (drawDateAndTime.hour < 10) {
      dateAndTime += '0${drawDateAndTime.hour}';
    } else {
      dateAndTime += '${drawDateAndTime.hour}';
    }

    dateAndTime += ':';

    if (drawDateAndTime.minute < 10) {
      dateAndTime += '0${drawDateAndTime.minute}';
    } else {
      dateAndTime += '${drawDateAndTime.minute}';
    }

    return dateAndTime;
  }
}
