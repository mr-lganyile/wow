import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class HowardArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    if (sectionName ==
        SectionName.howardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "1",
        townOrInstitutionName: TownOrInstitution.howardUKZN,
        townOrInstitutionNo: "4",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.howardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "4",
          sectionName: sectionName,
          areaNo: "30",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.howardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.howardCollegeCampusUKZNDurbanKwaZuluNatalSouthAfrica:
        return 'Howard College (UKZN)-Durban-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}
