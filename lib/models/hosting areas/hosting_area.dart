import '../converter.dart';
import '../locations/section_name.dart';

// Collection Name /stores/storeId
// Branch : store_resources_crud ->  create_store_resources_store_front_end
class HostingArea {
  String hostingAreaId;
  String hostingAreaName;
  String hostingAreaImageURL;
  SectionName sectionName;
  String pickUpArea;

  HostingArea({
    required this.hostingAreaId,
    required this.hostingAreaName,
    required this.hostingAreaImageURL,
    required this.sectionName,
    required this.pickUpArea,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'hostingAreaName': hostingAreaName,
      'hostingAreaId': hostingAreaId,
      'hostingAreaImageURL': hostingAreaImageURL,
      'sectionName': sectionName,
      'pickUpArea': pickUpArea,
    });
    return map;
  }

  factory HostingArea.fromJson(dynamic json) {
    return HostingArea(
        hostingAreaId: json['hostingAreaId'],
        hostingAreaName: json['hostingAreaName'],
        hostingAreaImageURL: json['hostingAreaImageURL'],
        sectionName: Converter.toSectionName(json['sectionName']),
        pickUpArea: json['pickUpArea']);
  }

  @override
  String toString() {
    return 'Hosting Area Name: $hostingAreaName '
        'Section Name: $sectionName  ';
  }
}
