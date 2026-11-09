import 'section_name.dart';
import 'supported_area.dart';
import 'supported_town_or_institution.dart';
import 'town_or_institution.dart';

class UmlaziArea {
  static SupportedTownOrInstitution? toSupportedTownOrInstitution(
      SectionName sectionName) {
    if (sectionName ==
            SectionName.aSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.aaSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.bSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.bbSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.cSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.ccSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.dSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.eSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.fSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.gSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.hSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.jSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.kSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.lSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.mSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.nSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.pSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.qSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.rSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.sSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.uSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.vSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.wSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.malukaziUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.ySectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName ==
            SectionName.zSectionUmlaziDurbanKwaZuluNatalSouthAfrica ||
        sectionName == SectionName.philaniUmlaziDurbanKwaZuluNatalSouthAfrica) {
      return SupportedTownOrInstitution(
        cityFK: "1",
        townOrInstitutionName: TownOrInstitution.umlazi,
        townOrInstitutionNo: "1",
      );
    }
    return null;
  }

  static SupportedArea? toSupportedArea(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.aSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "1",
        );
      case SectionName.aaSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "2",
        );
      case SectionName.bSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "3",
        );
      case SectionName.bbSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "4",
        );
      case SectionName.cSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "5",
        );
      case SectionName.ccSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "6",
        );
      case SectionName.dSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "7",
        );
      case SectionName.eSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "8",
        );
      case SectionName.fSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "9",
        );
      case SectionName.gSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "10",
        );
      case SectionName.hSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "11",
        );
      case SectionName.jSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "12",
        );
      case SectionName.kSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "13",
        );
      case SectionName.lSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "14",
        );
      case SectionName.mSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "15",
        );
      case SectionName.nSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "16",
        );
      case SectionName.pSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "17",
        );
      case SectionName.qSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "18",
        );
      case SectionName.rSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "19",
        );
      case SectionName.sSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "20",
        );
      case SectionName.uSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "21",
        );
      case SectionName.vSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "22",
        );
      case SectionName.wSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "23",
        );
      case SectionName.malukaziUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "24",
        );
      case SectionName.philaniUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "25",
        );
      case SectionName.ySectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "26",
        );
      case SectionName.zSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return SupportedArea(
          townOrInstitutionFK: "1",
          sectionName: sectionName,
          areaNo: "27",
        );
      default:
        return null;
    }
  }

  static SectionName? toSectionName(String section) {
    switch (section) {
      case 'A Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.aSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.aaSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'B Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.bSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.bbSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'C Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.cSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'CC Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.ccSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'D Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.dSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'E Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.eSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'F Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.fSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'G Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.gSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.hSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'J Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.jSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'K Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.kSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'L Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.lSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'M Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.mSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'N Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.nSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'P Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.pSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'Q Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.qSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'R Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.rSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'S Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.sSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'U Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.uSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.vSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'W Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.wSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.malukaziUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'Y Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.ySectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'Z Section-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.zSectionUmlaziDurbanKwaZuluNatalSouthAfrica;
      case 'Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa':
        return SectionName.philaniUmlaziDurbanKwaZuluNatalSouthAfrica;
      default:
        return null;
    }
  }

  static String? asString(SectionName sectionName) {
    switch (sectionName) {
      case SectionName.aSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'A Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.aaSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'AA Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.bSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'B Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.bbSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'BB Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.cSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'C Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.ccSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'CC Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.dSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'D Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.eSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'E Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.fSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'F Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.gSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'G Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.hSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'H Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.jSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'J Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.kSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'K Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.lSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'L Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.mSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'M Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.nSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'N Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.pSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'P Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.qSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'Q Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.rSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'R Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.sSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'S Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.uSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'U Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.vSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'V Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.wSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'W Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.malukaziUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'Malukazi-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.ySectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'Y Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.zSectionUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'Z Section-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      case SectionName.philaniUmlaziDurbanKwaZuluNatalSouthAfrica:
        return 'Philani-Umlazi-Durban-Kwa Zulu Natal-South Africa';
      default:
        return null;
    }
  }
}
