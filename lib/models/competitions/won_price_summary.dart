import 'dart:developer' as debug;

import '../locations/supported_area.dart';
import '../locations/supported_town_or_institution.dart';

// Collection Name /won_prices_summaries/wonPriceSummaryId
// Branch : won_price_summary_resources_crud -> create_won_price_summary_front_end
class WonPriceSummary implements Comparable<WonPriceSummary> {
  String wonPriceSummaryId; // Same as the storeDrawId & competitionId

  String hostingAreaFK;
  String hostingAreaImageURL;
  String hostName;
  SupportedTownOrInstitution townOrInstitution;
  SupportedArea groupArea;
  String? groupSpecificArea;
  String pickUpSpot;
  String wonGroupId;

  String wonGrandPriceImageURL;
  String groupCreatorPhoneNumber;
  String groupCreatorUsername;
  String groupCreatorImageURL;
  String groupName;
  List<String> groupMembers;

  String grandPriceDescription;

  DateTime wonDate;

  WonPriceSummary({
    required this.wonGroupId,
    required this.wonPriceSummaryId,
    required this.hostingAreaFK,
    required this.hostingAreaImageURL,
    required this.hostName,
    required this.groupArea,
    required this.townOrInstitution,
    required this.pickUpSpot,
    required this.groupCreatorPhoneNumber,
    required this.groupCreatorUsername,
    required this.groupCreatorImageURL,
    required this.groupName,
    required this.groupMembers,
    required this.grandPriceDescription,
    required this.wonGrandPriceImageURL,
    required this.wonDate,
    this.groupSpecificArea,
  });

  factory WonPriceSummary.fromJson(dynamic json) {
    debug.log(json['wonDate'].toString());
    return WonPriceSummary(
      wonGroupId: json['wonGroupId'],
      wonPriceSummaryId: json['wonPriceSummaryId'],
      hostingAreaFK: json['hostingAreaFK'],
      hostingAreaImageURL: json['hostingAreaImageURL'],
      hostName: json['hostName'],
      pickUpSpot: json['pickUpSpot'],
      groupCreatorPhoneNumber: json['groupCreatorPhoneNumber'],
      groupCreatorImageURL: json['groupCreatorImageURL'],
      groupCreatorUsername: json['groupCreatorUsername'],
      groupName: json['groupName'],
      groupArea: SupportedArea.fromJson(json['groupArea']),
      townOrInstitution: SupportedTownOrInstitution.fromJson(
        json['groupTownOrInstitution'],
      ),
      groupMembers: getGroupMembers(json['groupMembers']),
      grandPriceDescription: json['grandPriceDescription'],
      wonGrandPriceImageURL: json['wonGrandPriceImageURL'],
      wonDate: DateTime(
        json['wonDate']['year'],
        json['wonDate']['month'],
        json['wonDate']['day'],
        json['wonDate']['hour'],
        json['wonDate']['minute'],
      ),
      groupSpecificArea:
          // ignore: prefer_if_null_operators
          json['groupSpecificArea'] == null ? null : json['groupSpecificArea'],
    );
  }

  @override
  int compareTo(WonPriceSummary other) {
    return other.wonDate.compareTo(wonDate);
  }
}

List<String> getGroupMembers(List<dynamic> groupMembers) {
  List<String> members = [];

  for (int i = 0; i < groupMembers.length; i++) {
    members.add(groupMembers[i] as String);
  }

  return members;
}
