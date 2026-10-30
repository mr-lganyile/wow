import '/models/languages/zulu.dart';
import 'package:get/get.dart';

import '../models/languages/english.dart';
import '../models/languages/language.dart';
import '../models/locations/town_or_institution.dart';

class LanguageController extends GetxController {
  static LanguageController languageController = Get.find();

  // ignore: prefer_final_fields
  Rx<Language> _language = Rx(Zulu());
  Language get language => _language.value;

  void setLanguage(TownOrInstitution townOrInstitution) {
    if (townOrInstitution == TownOrInstitution.durbanCentral) {
      _language = Rx(Zulu());
    } else {
      _language = Rx(English());
    }
  }
}
