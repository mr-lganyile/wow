import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/locations/supported_town_or_institution.dart';
import '/models/locations/supported_area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Branch : supported_locations_resources_crud ->  supported_locations_resources_data_access
class LocationController extends GetxController {
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  int supportedAreasPageMultiple = 0;

  LocationController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  static LocationController locationController = Get.find();

  Stream<List<SupportedArea>> readAllSupportedAreas() {
    Stream<List<SupportedArea>> stream = FirebaseFirestore.instance
        .collection('supported_areas')
        .orderBy('areaName')
        // .limit(++supportedAreasPageMultiple * 10)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            SupportedArea info = SupportedArea.fromJson(doc.data());
            return info;
          }).toList(),
        );

    return stream;
  }

  Stream<List<SupportedTownOrInstitution>>
  readAllSupportedTownsOrSuburbsOrInstitutions() {
    Stream<List<SupportedTownOrInstitution>> stream = FirebaseFirestore.instance
        .collection('supported_towns_or_institutions')
        .orderBy('townOrInstitutionName')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            SupportedTownOrInstitution info =
                SupportedTownOrInstitution.fromJson(doc.data());
            return info;
          }).toList(),
        );

    return stream;
  }
}
