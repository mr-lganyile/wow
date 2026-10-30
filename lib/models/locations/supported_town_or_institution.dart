// Collection Name /supported_towns_or_institutions/{townOrInstitutionId}

import '../converter.dart';
import 'town_or_institution.dart';

class SupportedTownOrInstitution {
  String townOrInstitutionNo;
  String cityFK;
  TownOrInstitution townOrInstitutionName;

  SupportedTownOrInstitution({
    this.townOrInstitutionNo = '7',
    this.cityFK = '1',
    this.townOrInstitutionName = TownOrInstitution.durbanCentral,
  });

  Map<String, dynamic> toJson() => {
    "townOrInstitutionNo": townOrInstitutionNo,
    "cityFK": cityFK,
    "townOrInstitutionName": Converter.townOrInstitutionAsString(
      townOrInstitutionName,
    ),
  };

  factory SupportedTownOrInstitution.fromJson(dynamic json) =>
      SupportedTownOrInstitution(
        townOrInstitutionNo: json['townOrInstitutionNo'],
        cityFK: json['cityFK'],
        townOrInstitutionName: Converter.toTownOrInstitution(
          json['townOrInstitutionName'],
        ),
      );

  @override
  String toString() {
    return Converter.townOrInstitutionAsString(townOrInstitutionName);
  }
}
