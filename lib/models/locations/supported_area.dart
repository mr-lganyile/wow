// Collection Name /supported_areas/{supportedAreaId}
// Branch : lsupported_locations_resources_crud ->  create_supported_locations_front_end

import '../converter.dart';
import 'section_name.dart';

class SupportedArea implements Comparable<SupportedArea> {
  String areaNo;
  String townOrInstitutionFK;
  SectionName sectionName;

  SupportedArea({
    this.areaNo = '44',
    this.townOrInstitutionFK = '7',
    this.sectionName =
        SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica,
  });

  Map<String, dynamic> toJson() => {
    "areaNo": areaNo,
    "townOrInstitutionFK": townOrInstitutionFK,
    "areaName": Converter.asString(sectionName),
  };

  factory SupportedArea.fromJson(dynamic json) => SupportedArea(
    areaNo: json['areaNo'],
    townOrInstitutionFK: json['townOrInstitutionFK'],
    sectionName: Converter.toSectionName(json['areaName']),
  );

  @override
  String toString() {
    return Converter.asString(sectionName);
  }

  @override
  int compareTo(SupportedArea other) {
    String thisTownOrInstitution = Converter.townOrInstitutionAsString(
      Converter.toSupportedTownOrInstitution(sectionName).townOrInstitutionName,
    );
    String otherTownOrInstitution = Converter.townOrInstitutionAsString(
      Converter.toSupportedTownOrInstitution(
        other.sectionName,
      ).townOrInstitutionName,
    );
    return thisTownOrInstitution.compareTo(otherTownOrInstitution);
  }
}
