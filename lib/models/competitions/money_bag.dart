import 'package:cloud_firestore/cloud_firestore.dart';

class MoneyBag implements Comparable<MoneyBag> {
  String moneyCollectorBagId; // Reciever of the bag.
  String senderSuperiorAdminFK;
  DateTime? moneyCollectorRecievedBy;
  Timestamp? moneyCollectorRecievedByTimeStamp;
  DateTime? moneyCollectorSubmittedBy;
  Timestamp? moneyCollectorSubmittedByTimeStamp;
  Map<String, String>
      relationships; // Key: +27734476372 ajhflalhjafjhlkaf Value: yellow
  bool hasMoneyCollectorSubmitted;

  MoneyBag({
    required this.moneyCollectorBagId, // Reciever of the bag.
    required this.senderSuperiorAdminFK,
    this.moneyCollectorRecievedBy,
    this.moneyCollectorRecievedByTimeStamp,
    this.moneyCollectorSubmittedBy,
    this.moneyCollectorSubmittedByTimeStamp,
    this.hasMoneyCollectorSubmitted = false,
    required this.relationships,
  });

  Map<String, dynamic> toJson() => {
        'moneyCollectorBagId': moneyCollectorBagId,
        'senderSuperiorAdminFK': senderSuperiorAdminFK,
        'moneyCollectorRecievedBy': moneyCollectorRecievedBy == null
            ? null
            : {
                'year': moneyCollectorRecievedBy!.year,
                'month': moneyCollectorRecievedBy!.month,
                'day': moneyCollectorRecievedBy!.day,
                'hour': moneyCollectorRecievedBy!.hour,
                'minute': moneyCollectorRecievedBy!.minute,
              },
        'moneyCollectorRecievedByTimeStamp': moneyCollectorRecievedByTimeStamp,
        'moneyCollectorSubmittedBy': moneyCollectorSubmittedBy == null
            ? null
            : {
                'year': moneyCollectorSubmittedBy!.year,
                'month': moneyCollectorSubmittedBy!.month,
                'day': moneyCollectorSubmittedBy!.day,
                'hour': moneyCollectorSubmittedBy!.hour,
                'minute': moneyCollectorSubmittedBy!.minute,
              },
        'moneyCollectorSubmittedByTimeStamp':
            moneyCollectorSubmittedByTimeStamp,
        'relationships': relationships,
        'hasMoneyCollectorSubmitted': hasMoneyCollectorSubmitted,
      };

  factory MoneyBag.fromJson(dynamic json) => MoneyBag(
      moneyCollectorBagId: json['moneyCollectorBagId'],
      senderSuperiorAdminFK: json['senderSuperiorAdminFK'],
      moneyCollectorRecievedBy: json['moneyCollectorRecievedBy'] == null
          ? null
          : DateTime(
              json['moneyCollectorRecievedBy']['year'],
              json['moneyCollectorRecievedBy']['month'],
              json['moneyCollectorRecievedBy']['day'],
              json['moneyCollectorRecievedBy']['hour'],
              json['moneyCollectorRecievedBy']['minute']),
      moneyCollectorRecievedByTimeStamp:
          json['moneyCollectorRecievedByTimeStamp'],
      moneyCollectorSubmittedBy: json['moneyCollectorSubmittedBy'] == null
          ? null
          : DateTime(
              json['moneyCollectorSubmittedBy']['year'],
              json['moneyCollectorSubmittedBy']['month'],
              json['moneyCollectorSubmittedBy']['day'],
              json['moneyCollectorSubmittedBy']['hour'],
              json['moneyCollectorSubmittedBy']['minute']),
      moneyCollectorSubmittedByTimeStamp:
          json['moneyCollectorSubmittedByTimeStamp'],
      relationships: convertToRelationship(json['relationships']),
      hasMoneyCollectorSubmitted: json['hasMoneyCollectorSubmitted']);

  @override
  int compareTo(MoneyBag other) {
    if (moneyCollectorRecievedByTimeStamp != null &&
        other.moneyCollectorRecievedByTimeStamp != null) {
      return moneyCollectorRecievedByTimeStamp!
          .compareTo(other.moneyCollectorRecievedByTimeStamp!);
    }

    return moneyCollectorBagId.compareTo(other.moneyCollectorBagId);
  }

  static Map<String, String> convertToRelationship(
      Map<String, dynamic> relationship) {
    Map<String, String> map = {};

    relationship.forEach((key, value) {
      map.addAll({key: value as String});
    });

    return map;
  }
}
