class RecruitmentHistory {
  String historyId;
  String adminPhoneNumber;
  String action;
  bool isRefresh;
  DateTime? dateCreated;

  RecruitmentHistory(
      {required this.adminPhoneNumber,
      required this.historyId,
      this.isRefresh = false,
      this.dateCreated,
      required this.action});

  Map<String, dynamic> toJson() => {
        'historyId': historyId,
        'adminPhoneNumber': adminPhoneNumber,
        'action': action,
        'isRefresh': isRefresh,
        'dateCreated': null,
      };

  factory RecruitmentHistory.fromJson(dynamic json) => RecruitmentHistory(
      adminPhoneNumber: json['adminPhoneNumber'],
      historyId: json['historyId'],
      isRefresh: json['isRefresh'],
      dateCreated: DateTime(json['year'], json['month'], json['day'],
          json['hour'], json['minute']),
      action: json['action']);
}
