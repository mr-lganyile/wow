import '../converter.dart';
import 'dart:developer' as debug;
import '../locations/section_name.dart';
import 'notification.dart';

// Branch : store_resources_crud ->  create_store_resources_store_front_end
class HostInfo implements Comparable<HostInfo> {
  String hostInfoId;
  String hostingAreaName;
  SectionName sectionName;
  String pickUpArea;
  String hostingAreaImageURL;
  bool canAddDraw;
  late String latestHostedDrawId;
  bool isCurrentlyViewed = false;
  List<String>? drawsOrder;
  Notification? notification;

  HostInfo({
    required this.hostInfoId,
    this.latestHostedDrawId = '-',
    required this.hostingAreaName,
    required this.sectionName,
    required this.pickUpArea,
    required this.hostingAreaImageURL,
    required this.canAddDraw,
    this.drawsOrder = const [],
    this.notification,
  });

  factory HostInfo.fromJson(dynamic json) => HostInfo(
    hostInfoId: json['hostInfoId'],
    hostingAreaName: json['hostingAreaName'],
    sectionName: Converter.toSectionName(json['sectionName']),
    pickUpArea: json['pickUpArea'],
    hostingAreaImageURL: json['hostingAreaImageURL'],
    latestHostedDrawId: json['latestHostedDrawId'],
    drawsOrder: convert(json['drawsOrder']),
    canAddDraw: json['canAddDraw'],
    notification: json["notification"] != null
        ? Notification.fromJson(json["notification"])
        : null,
  );

  void setIsCurrentlyViewed(bool isCurrentlyViewed) {
    this.isCurrentlyViewed = isCurrentlyViewed;
  }

  @override
  int compareTo(HostInfo other) {
    return other.hostingAreaName.compareTo(hostingAreaName);
  }

  String getCommingDrawId() {
    // debug.log(drawsOrder!.toString());
    if (drawsOrder!.isNotEmpty) {
      // debug.log('Next Comming Draw ${drawsOrder![0]}');
      return drawsOrder![0];
    }
    // debug.log('Next Comming Draw - ');
    return "-";
  }

  static List<String>? convert(List<dynamic> list) {
    List<String>? order = [];

    for (dynamic item in list) {
      order.add(item);
    }
    order.sort();
    return order;
  }
}
