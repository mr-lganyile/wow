import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class DurbanCentralArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
      SectionName sectionName) {
    if (sectionName ==
            SectionName.glenwoodDurbanCentralDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.southBeachDurbanCentralDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.masgraveDurbanCentralDurbanKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "1",
        townOrInstitutionName: TownOrInstitution.durbanCentral,
        townOrInstitutionNo: "7",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.glenwoodDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "7",
          sectionName: sectionName,
          areaNo: "43",
        );
      case SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "7",
          sectionName: sectionName,
          areaNo: "44",
        );
      case SectionName.southBeachDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "7",
          sectionName: sectionName,
          areaNo: "45",
        );
      case SectionName.masgraveDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "7",
          sectionName: sectionName,
          areaNo: "46",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'Glenwood-Durban Central-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.glenwoodDurbanCentralDurbanKwaZuluNatalSouthAfrica;
      case 'Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica;
      case 'South Beach-Durban Central-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.southBeachDurbanCentralDurbanKwaZuluNatalSouthAfrica;
      case 'Masgrave-Durban Central-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.masgraveDurbanCentralDurbanKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.glenwoodDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return 'Glenwood-Durban Central-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return 'Berea-Durban Central-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.southBeachDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return 'South Beach-Durban Central-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.masgraveDurbanCentralDurbanKwaZuluNatalSouthAfrica:
        return 'Masgrave-Durban Central-Durban-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}
