import 'package:wow/models/locations/durban_central_area.dart';

import '/models/competitions/voucher_type.dart';

import '/models/competitions/competition_state.dart';

import 'locations/howard_area.dart';
import 'locations/section_name.dart';
import 'hosting areas/hosted_draw_state.dart';
import 'locations/supported_area.dart';
import 'locations/supported_town_or_institution.dart';
import 'locations/town_or_institution.dart';
import '/models/users/admin.dart';

// groups_crud -> group_resources_crud ->  create_group_resources_front_end
class Converter {
  static String toAdminTypeAsString(AdminType adminType) {
    switch (adminType) {
      case AdminType.groupRegistery:
        return 'Group Registery';
      case AdminType.moneyCollector:
        return 'Money Collector';
      default:
        return 'Both';
    }
  }

  static AdminType toAdminType(String adminType) {
    switch (adminType) {
      case 'Group Registery':
        return AdminType.groupRegistery;
      case 'Money Collector':
        return AdminType.moneyCollector;

      default:
        return AdminType.groupRegisteryAndmoneyCollector;
    }
  }

  static String toVoucherAsString(VoucherType voucherType) {
    switch (voucherType) {
      case VoucherType.blueVoucher:
        return 'Blue Voucher';
      case VoucherType.easyload:
        return 'Easy Load';
      case VoucherType.easypay:
        return 'Easy Pay';
      case VoucherType.oneVoucher:
        return '1Voucher';
      default:
        return 'OTT';
    }
  }

  static toVoucherType(String voucherType) {
    switch (voucherType) {
      case 'Blue Voucher':
        return VoucherType.blueVoucher;
      case 'Easy Load':
        return VoucherType.easyload;
      case 'Easy Pay':
        return VoucherType.easypay;
      case '1Voucher':
        return VoucherType.oneVoucher;
      default:
        return VoucherType.ott;
    }
  }

  // Branch : competition_resources_crud ->  create_competition_resources_front_end
  static HostedDrawState toHostedDrawState(String state) {
    switch (state) {
      case "converted-to-competition":
        return HostedDrawState.convertedToCompetition;
      default:
        return HostedDrawState.notConvertedToCompetition;
    }
  }

  // Branch : competition_resources_crud ->  create_competition_resources_front_end
  static String fromHostedDrawStateToString(HostedDrawState storeDrawState) {
    switch (storeDrawState) {
      case HostedDrawState.convertedToCompetition:
        return "converted-to-competition";
      default:
        return "not-converted-to-competition";
    }
  }

  // Branch : competition_resources_crud ->  create_competition_resources_front_end
  static CompetitionState toCompetitionState(String state) {
    switch (state) {
      case "on-count-down":
        return CompetitionState.onCountDown;
      case "picking-won-grand-price":
        return CompetitionState.pickingWonGrandPrice;
      default:
        return CompetitionState.pickingWonGroup;
    }
  }

  // Branch : competition_resources_crud ->  create_competition_resources_front_end
  static String fromCompetitionStateToString(
    CompetitionState competitionState,
  ) {
    switch (competitionState) {
      case CompetitionState.onCountDown:
        return "on-count-down";
      case CompetitionState.pickingWonGrandPrice:
        return "picking-won-grand-price";
      default:
        return "picking-won-group";
    }
  }

  // Default durban central
  static SupportedTownOrInstitution toSupportedTownOrInstitution(
    SectionName sectionName,
  ) {
    SupportedTownOrInstitution? supportedTownOrInstitution =
        HowardArea.toSupportedTownOrInstitution(sectionName);

    supportedTownOrInstitution ??= SupportedTownOrInstitution(
      cityFK: "1",
      townOrInstitutionName: TownOrInstitution.durbanCentral,
      townOrInstitutionNo: "7",
    );

    return supportedTownOrInstitution;
  }

  // Default durban central [berea]
  static SupportedArea toSupportedArea(SectionName sectionName) {
    SupportedArea? supportedArea = DurbanCentralArea.toSupportedArea(
      sectionName,
    );
    supportedArea ??= HowardArea.toSupportedArea(sectionName);

    return supportedArea!;
  }

  // Default to Berea
  static SectionName toSectionName(String section) {
    SectionName? sectionName = DurbanCentralArea.toSectionName(section);
    sectionName ??= HowardArea.toSectionName(section);
    return sectionName!;
  }

  // Default to Berea
  static String asString(SectionName sectionName) {
    String? section = DurbanCentralArea.asString(sectionName);
    section ??= HowardArea.asString(sectionName);

    return section!;
  }

  static bool isInstitution(SectionName sectionName) {
    String sectionNameAsString = Converter.asString(sectionName);
    String firstPortion = sectionNameAsString.substring(
      0,
      sectionNameAsString.indexOf('-'),
    );
    return firstPortion.contains('DUT') ||
        firstPortion.contains('Howard College (UKZN)') ||
        firstPortion.contains('Westville (UKZN)') ||
        firstPortion.contains('Nelson Mandela (UKZN)') ||
        firstPortion.contains('Edgewood (UKZN)') ||
        firstPortion.contains('PMB (UKZN)') ||
        firstPortion.contains('Mangosuthu (MUT)');
  }

  // Default to durban central
  static int townOrInstitutionAsNumber(TownOrInstitution townOrInstitution) {
    switch (townOrInstitution) {
      /*
      case TownOrInstitution.umlazi:
        return 1;
      case TownOrInstitution.mut:
        return 2;
      case TownOrInstitution.dut:
        return 3; */
      case TownOrInstitution.howardUKZN:
        return 4;
      /*
      case TownOrInstitution.mayville:
        return 5;
      case TownOrInstitution.sydenham:
        return 6;
      case TownOrInstitution.nanda:
        return 8;
      case TownOrInstitution.hammarsdale:
        return 9;
      case TownOrInstitution.westvilleUKZN:
        return 10;
      case TownOrInstitution.nelsonMandelUKZN:
        return 11;
      case TownOrInstitution.edgewoodUKZN:
        return 12;
      case TownOrInstitution.pmbUKZN:
        return 13; */
      default:
        return 7;
    }
  }

  // Default to durban central
  static String townOrInstitutionAsString(TownOrInstitution townOrInstitution) {
    switch (townOrInstitution) {
      /*
      case TownOrInstitution.umlazi:
        return 'Umlazi';
      case TownOrInstitution.mut:
        return 'Mangosuthu (MUT)';
      case TownOrInstitution.dut:
        return 'DUT'; */
      case TownOrInstitution.howardUKZN:
        return 'Howard College (UKZN)';
      /*
      case TownOrInstitution.westvilleUKZN:
        return 'Westville (UKZN)';
      case TownOrInstitution.nelsonMandelUKZN:
        return 'Nelson Mandela (UKZN)';
      case TownOrInstitution.edgewoodUKZN:
        return 'Edgewood (UKZN)';
      case TownOrInstitution.pmbUKZN:
        return 'PMB (UKZN)';
      case TownOrInstitution.mayville:
        return 'Mayville';
      case TownOrInstitution.sydenham:
        return 'Sydenham';
      case TownOrInstitution.nanda:
        return 'Nanda';
      case TownOrInstitution.hammarsdale:
        return 'Hammarsdale'; */
      default:
        return 'Durban Central';
    }
  }

  // Default to durban central
  static TownOrInstitution toTownOrInstitution(String townOrInstitution) {
    switch (townOrInstitution) {
      /*
      case 'Umlazi':
        return TownOrInstitution.umlazi;
      case 'Mangosuthu (MUT)':
        return TownOrInstitution.mut;
      case 'DUT':
        return TownOrInstitution.dut; */
      case 'Howard College (UKZN)':
        return TownOrInstitution.howardUKZN;
      /*
      case 'Westville (UKZN)':
        return TownOrInstitution.westvilleUKZN;
      case 'Nelson Mandela (UKZN)':
        return TownOrInstitution.nelsonMandelUKZN;
      case 'Edgewood (UKZN)':
        return TownOrInstitution.edgewoodUKZN;
      case 'PMB (UKZN)':
        return TownOrInstitution.pmbUKZN;
      case 'Mayville':
        return TownOrInstitution.mayville;
      case 'Sydenham':
        return TownOrInstitution.sydenham;
      case 'Nanda':
        return TownOrInstitution.nanda;
      case 'Hammarsdale':
        return TownOrInstitution.hammarsdale; */
      default:
        return TownOrInstitution.durbanCentral;
    }
  }
}
