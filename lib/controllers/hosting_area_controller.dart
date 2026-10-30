import 'dart:io';

import '../../models/locations/town_or_institution.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/hosting areas/draw_grand_price.dart';
import '../models/hosting areas/hosted_draw.dart';
import '../models/hosting areas/host_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hosting areas/hosting_area.dart';
import 'dart:developer' as debug;

import '../models/converter.dart';
import '../models/hosting areas/notification.dart';
import '../models/users/abstract_user.dart';
import '../models/users/user.dart' as my;
import '../screens/utils/globals.dart';

enum HostedDrawSavingStatus { loginRequired, incomplete, saved, notSaved }

enum NoticeSavingStatus { adminLoginRequired, incomplete, saved }

// Branch : store_resources_crud ->  store_resources_crud_data_access
class HostingAreaController extends GetxController {
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  HostingAreaController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  final drawKeyPart = 'kankuxa';

  static HostingAreaController hostingAreaController = Get.find();

  // ignore: prefer_final_fields
  Rx<String?> _groupToWinPhoneNumber = Rx('N/A');
  String? get groupToWinPhoneNumber => _groupToWinPhoneNumber.value;

  Rx<String?> _groupToWinId = Rx('N/A');
  String? get groupToWinId => _groupToWinId.value;

  Rx<TownOrInstitution?> _currentHostTownOrInstitution = Rx(null);
  TownOrInstitution? get currentHostTownOrInstitution =>
      _currentHostTownOrInstitution.value;

  late Rx<HostingArea?> _hostingArea = Rx<HostingArea?>(null);
  HostingArea? get hostingArea => _hostingArea.value;

  late Rx<File?> hostPickedFile;
  File? get hostImageFile => hostPickedFile.value;

  late Rx<int?> _drawDateYear = Rx<int?>(-1);
  int? get drawDateYear => _drawDateYear.value;

  late Rx<int?> _drawDateMonth = Rx<int?>(-1);
  int? get drawDateMonth => _drawDateMonth.value;

  late Rx<int?> _drawDateDay = Rx<int?>(-1);
  int? get drawDateDay => _drawDateDay.value;

  late Rx<int?> _drawDateHour = Rx<int?>(-1);
  int? get drawDateHour => _drawDateHour.value;

  late Rx<int?> _drawDateMinute = Rx<int?>(-1);
  int? get drawDateMinute => _drawDateMinute.value;

  late Rx<File?> _drawGrandPrice1ImageFile;
  File? get drawGrandPrice1ImageFile => _drawGrandPrice1ImageFile.value;
  late Rx<String?> _grandPrice1ImageURL = Rx<String?>('');
  String? get grandPrice1ImageURL => _grandPrice1ImageURL.value;
  late Rx<String?> _description1 = Rx<String?>('');
  String? get description1 => _description1.value;

  late Rx<File?> _drawGrandPrice2ImageFile;
  File? get drawGrandPrice2ImageFile => _drawGrandPrice2ImageFile.value;
  late Rx<String?> _grandPrice2ImageURL = Rx<String?>('');
  String? get grandPrice2ImageURL => _grandPrice2ImageURL.value;
  late Rx<String?> _description2 = Rx<String?>('');
  String? get description2 => _description2.value;

  late Rx<File?> _drawGrandPrice3ImageFile;
  File? get drawGrandPrice3ImageFile => _drawGrandPrice3ImageFile.value;
  late Rx<String?> _grandPrice3ImageURL = Rx<String?>('');
  String? get grandPrice3ImageURL => _grandPrice3ImageURL.value;
  late Rx<String?> _description3 = Rx<String?>('');
  String? get description3 => _description3.value;

  late Rx<File?> _drawGrandPrice4ImageFile;
  File? get drawGrandPrice4ImageFile => _drawGrandPrice4ImageFile.value;
  late Rx<String?> _grandPrice4ImageURL = Rx<String?>('');
  String? get grandPrice4ImageURL => _grandPrice4ImageURL.value;
  late Rx<String?> _description4 = Rx<String?>('');
  String? get description4 => _description4.value;

  late Rx<File?> _drawGrandPrice5ImageFile;
  File? get drawGrandPrice5ImageFile => _drawGrandPrice5ImageFile.value;
  late Rx<String?> _grandPrice5ImageURL = Rx<String?>('');
  String? get grandPrice5ImageURL => _grandPrice5ImageURL.value;
  late Rx<String?> _description5 = Rx<String?>('');
  String? get description5 => _description5.value;

  late Rx<int?> _grandPriceToWinIndex = Rx<int?>(-1);
  int? get grandPriceToWinIndex => _grandPriceToWinIndex.value;

  late Rx<String?> _adminCode = Rx<String?>(null);
  String? get adminCode => _adminCode.value;

  void cleanForStoreDraw() {
    _hostingArea = Rx<HostingArea?>(null);
    _drawDateYear = Rx<int?>(-1);
    _drawDateMonth = Rx<int?>(-1);
    _drawDateDay = Rx<int?>(-1);
    _drawDateHour = Rx<int?>(-1);
    _drawDateMinute = Rx<int?>(-1);

    _drawGrandPrice1ImageFile = Rx(null);
    _grandPrice1ImageURL = Rx<String?>('');
    _description1 = Rx<String?>('');

    _drawGrandPrice2ImageFile = Rx(null);
    _grandPrice2ImageURL = Rx<String?>('');
    _description2 = Rx<String?>('');

    _drawGrandPrice3ImageFile = Rx(null);
    _grandPrice3ImageURL = Rx<String?>('');
    _description3 = Rx<String?>('');

    _drawGrandPrice4ImageFile = Rx(null);
    _grandPrice4ImageURL = Rx<String?>('');
    _description4 = Rx<String?>('');

    _drawGrandPrice5ImageFile = Rx(null);
    _grandPrice5ImageURL = Rx<String?>('');
    _description5 = Rx<String?>('');

    _grandPriceToWinIndex = Rx<int?>(-1);
    _groupToWinPhoneNumber = Rx('N/A');
    _groupToWinId = Rx('N/A');

    update();
  }

  // Branch : store_resources_crud ->  store_resources_crud_data_access
  void chooseStoreImageFromGallery() async {
    final hostPickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (hostPickedImageFile != null) {
      //getSnapbar('Image Status', 'Image File Successfully Picked.');
    }

    // Share the chosen image file on Getx State Management.
    hostPickedFile = Rx<File?>(File(hostPickedImageFile!.path));
  }

  // Branch : store_resources_crud ->  store_resources_crud_data_access
  void captureStoreImageWithCamera() async {
    final storePickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (storePickedImageFile != null) {
      getSnapbar('Image Status', 'Image File Successfully Captured.');
    }

    // Share the chosen image file on Getx State Management.
    hostPickedFile = Rx<File?>(File(storePickedImageFile!.path));
  }

  /*===========================Stores [Start]============================= */

  // Branch : store_resources_crud ->  store_resources_crud_data_access
  Future<HostingArea?> findHostingArea(String hostingAreaId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('hosting_areas')
        .doc(hostingAreaId);

    DocumentSnapshot snapshot = await reference.get();

    if (snapshot.exists) {
      return HostingArea.fromJson(snapshot.data()!);
    }

    return null;
  }

  Future<void> initiateHostingStore(String hostingAreaId) async {
    DocumentReference hostingAreaReference = firestore
        .collection('hosting_areas')
        .doc(hostingAreaId);

    DocumentSnapshot snapshot = await hostingAreaReference.get();

    if (snapshot.exists) {
      HostingArea hostingArea = HostingArea.fromJson(snapshot.data()!);
      _hostingArea = Rx<HostingArea?>(hostingArea);
    }
  }

  /*===========================Stores [End]============================= */

  /*======================Host Info [Start]======================== */
  // Branch : store_resources_crud ->  store_resources_crud_data_access
  Stream<DocumentSnapshot> retrieveHostInfo(String hostInfoId) {
    return FirebaseFirestore.instance
        .collection("hosts_info")
        .doc(hostInfoId)
        .snapshots();
  }

  // Branch : store_resources_crud ->  store_resources_crud_data_access
  Future<HostInfo?> findHostInfo(String hostInfoId) async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection("hosts_info")
        .doc(hostInfoId);

    reference.snapshots().map((referenceDoc) {
      return HostInfo.fromJson(referenceDoc.data());
    });

    return null;
  }

  // Branch : store_resources_crud ->  store_resources_crud_data_access
  Stream<List<HostInfo>> readAllHostInfo() {
    Stream<List<HostInfo>> stream = FirebaseFirestore.instance
        .collection('hosts_info')
        .snapshots()
        .map((snapshot) {
          List<HostInfo> list = snapshot.docs.map((doc) {
            HostInfo info = HostInfo.fromJson(doc.data());
            return info;
          }).toList();
          list.shuffle();
          return list;
        });

    return stream;
  }

  // Branch : store_resources_crud ->  store_resources_crud_data_access
  void updateDrawsOrder(String hostInfoId) async {
    DocumentReference hostInfoReference = firestore
        .collection("hosts_info")
        .doc(hostInfoId);

    hostInfoReference.get().then((hostInfoDoc) async {
      HostInfo info = HostInfo.fromJson(hostInfoDoc.data());

      debug.log('Before Draw Order Update ${info.drawsOrder!}');

      if (info.drawsOrder!.isNotEmpty) {
        await hostInfoReference.update({
          'drawsOrder': FieldValue.arrayRemove([info.drawsOrder![0]]),
        });
      }
      debug.log('After Draw Order Update ${info.drawsOrder!}');
    });
  }

  /*======================Host Info [End]======================== */

  /*=========================Store Draws [Start]========================= */

  String trimmedImageURL(int index) {
    int start;
    switch (index) {
      case 0:
        start = _grandPrice1ImageURL.value!.indexOf('/o') + 2;
        debug.log(_grandPrice1ImageURL.value!);

        return start != -1
            ? _grandPrice1ImageURL.value!
                  .substring(start, _grandPrice1ImageURL.value!.indexOf('?'))
                  .replaceAll('%2F', '/')
                  .replaceAll('%40', '@')
                  .replaceAll('%3A', ':')
            : _grandPrice1ImageURL.value!;
      case 1:
        start = _grandPrice2ImageURL.value!.indexOf('/o') + 2;

        return start != -1
            ? _grandPrice2ImageURL.value!
                  .substring(start, _grandPrice2ImageURL.value!.indexOf('?'))
                  .replaceAll('%2F', '/')
                  .replaceAll('%40', '@')
                  .replaceAll('%3A', ':')
            : _grandPrice2ImageURL.value!;
      case 2:
        start = _grandPrice3ImageURL.value!.indexOf('/o') + 2;

        return start != -1
            ? _grandPrice3ImageURL.value!
                  .substring(start, _grandPrice3ImageURL.value!.indexOf('?'))
                  .replaceAll('%2F', '/')
                  .replaceAll('%40', '@')
                  .replaceAll('%3A', ':')
            : _grandPrice3ImageURL.value!;
      case 3:
        start = _grandPrice4ImageURL.value!.indexOf('/o') + 2;

        return start != -1
            ? _grandPrice4ImageURL.value!
                  .substring(start, _grandPrice4ImageURL.value!.indexOf('?'))
                  .replaceAll('%2F', '/')
                  .replaceAll('%40', '@')
                  .replaceAll('%3A', ':')
            : _grandPrice4ImageURL.value!;
      default:
        start = _grandPrice5ImageURL.value!.indexOf('/o') + 2;

        return start != -1
            ? _grandPrice5ImageURL.value!
                  .substring(start, _grandPrice5ImageURL.value!.indexOf('?'))
                  .replaceAll('%2F', '/')
                  .replaceAll('%40', '@')
                  .replaceAll('%3A', ':')
            : _grandPrice5ImageURL.value!;
    }
  }

  // Branch : competition_resources_crud ->  competitions_data_access
  Stream<List<HostedDraw>> findHostedDraws(String hostingAreaFK) {
    return FirebaseFirestore.instance
        .collection('hosting_areas')
        .doc(hostingAreaFK)
        .collection('hosted_draws')
        .orderBy('drawDateAndTime.year', descending: false)
        .orderBy('drawDateAndTime.month', descending: false)
        .orderBy('drawDateAndTime.day', descending: false)
        .orderBy('drawDateAndTime.hour', descending: false)
        .orderBy('drawDateAndTime.minute', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => HostedDraw.fromJson(doc.data()))
              .toList(),
        );
  }

  // Branch : competition_resources_crud ->  competitions_data_access
  Stream<DocumentSnapshot<Object?>> retrieveHostedDraw(
    String hostingAreaFK,
    String hostedDrawId,
  ) {
    DocumentReference reference = FirebaseFirestore.instance
        .collection('hosting_areas')
        .doc(hostingAreaFK)
        .collection('hosted_draws')
        .doc(hostedDrawId);

    return reference.snapshots();
  }

  Stream<List<HostedDraw>> retrieveHostedDraws(String hostingAreaFK) {
    final query = firestore
        .collectionGroup('hosted_draws')
        .where('hostingAreaFK', isEqualTo: hostingAreaFK)
        .snapshots();

    return query.map(((hostedDrawsSnapshot) {
      List<HostedDraw> hostedDraws = hostedDrawsSnapshot.docs.map((
        storeDrawDoc,
      ) {
        return HostedDraw.fromJson(storeDrawDoc.data());
      }).toList();
      hostedDraws.sort();
      debug.log("Hosted Draws Size ${hostedDraws.length}");
      return hostedDraws;
    }));
  }

  // Update - reference.update({'key': 'new value'} or {'param.key': 'new value'})
  // Remove A Field - update({'key': FieldValue.delete())
  void updateIsOpen(String hostingAreaFK, String hostedDrawId, bool isOpen) {
    FirebaseFirestore.instance
        .collection('hosting_areas')
        .doc(hostingAreaFK)
        .collection('hosted_draws')
        .doc(hostedDrawId)
        .update({'Is Open': isOpen});
  }

  void updateJoiningFee(
    String hostingAreaFK,
    String hostedDrawId,
    double joiningFee,
  ) {
    if (joiningFee > 0) {
      FirebaseFirestore.instance
          .collection('hosting_areas')
          .doc(hostingAreaFK)
          .collection('hosted_draws')
          .doc(hostedDrawId)
          .update({'Is Open': joiningFee});
    }
  }

  void setDescription(int grandPriceIndex, String description) {
    switch (grandPriceIndex) {
      case 0:
        _description1 = Rx<String?>(description);
        break;
      case 1:
        _description2 = Rx<String?>(description);
        break;
      case 2:
        _description3 = Rx<String?>(description);
        break;
      case 3:
        _description4 = Rx<String?>(description);
        break;
      default:
        _description5 = Rx<String?>(description);
    }
  }

  void chooseGrandPriceImageFromGallery(int grandPriceIndex) async {
    if (_hostingArea.value == null) {
      getSnapbar('Error', 'Host Not Chosen.');
      return;
    }
    int year = _drawDateYear.value!,
        month = _drawDateMonth.value!,
        day = _drawDateDay.value!,
        hour = _drawDateHour.value!,
        minute = _drawDateMinute.value!;
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImageFile != null) {
      String grandPriceId = '$day-$month-$year@$hour:$minute-$grandPriceIndex';
      String host = _hostingArea.value!.hostingAreaName.toLowerCase();

      switch (grandPriceIndex) {
        case 0:
          _drawGrandPrice1ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice1ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice1ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );

          break;
        case 1:
          _drawGrandPrice2ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice2ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice2ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        case 2:
          _drawGrandPrice3ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice3ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice3ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        case 3:
          _drawGrandPrice4ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice4ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice4ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        default:
          _drawGrandPrice5ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice5ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice5ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
      }
      getSnapbar('Image Status', 'Image File Successfully Chosen.');
      update();
    }
  }

  void captureGrandPriceImageFromCamera(int grandPriceIndex) async {
    if (_hostingArea.value == null) {
      getSnapbar('Error', 'Host Not Chosen.');
      return;
    }

    int year = _drawDateYear.value!,
        month = _drawDateMonth.value!,
        day = _drawDateDay.value!,
        hour = _drawDateHour.value!,
        minute = _drawDateMinute.value!;
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImageFile != null) {
      String grandPriceId = '$day-$month-$year@$hour:$minute-$grandPriceIndex';
      String host = _hostingArea.value!.hostingAreaName.toLowerCase();

      switch (grandPriceIndex) {
        case 0:
          _drawGrandPrice1ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice1ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice1ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        case 1:
          _drawGrandPrice2ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice2ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice2ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        case 2:
          _drawGrandPrice3ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice3ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice3ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        case 3:
          _drawGrandPrice4ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice4ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice4ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
          break;
        default:
          _drawGrandPrice5ImageFile = Rx<File?>(File(pickedImageFile.path));
          _grandPrice5ImageURL = Rx<String?>(
            await uploadResource(
              _drawGrandPrice5ImageFile.value!,
              '$host/grand_prices_images/$grandPriceId',
            ),
          );
      }
      update();
    }
  }

  // Supposed To Be A Backend Function.
  bool hasAcceptableAdminCredentials() {
    return _adminCode.value != null &&
        (_adminCode.value!.compareTo('$drawKeyPart@NUZ') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@MUT') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@DUT') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@UKZN') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@MAYV') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@SYD') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@DBNC') == 0 ||
            _adminCode.value!.compareTo('$drawKeyPart@NANDA') == 0);
  }

  // Supposed To Be A Backend Function.
  void setAdminCode(String adminCode) {
    if (adminCode.contains('$drawKeyPart@UKZN') &&
        '$drawKeyPart@UKZN'.contains(adminCode)) {
      _currentHostTownOrInstitution = Rx(TownOrInstitution.howardUKZN);
      initiateHostingStore('d4drbsfkrnds48dnmd');
    } else if (adminCode.contains('$drawKeyPart@DBNC') &&
        '$drawKeyPart@DBNC'.contains(adminCode)) {
      _currentHostTownOrInstitution = Rx(TownOrInstitution.durbanCentral);
      initiateHostingStore('g4drbsfkrnds48dnmd');
    } else if (adminCode.isNotEmpty) {
      getSnapbar('Error', 'Incorrect Admin Code.');
    }

    _adminCode = Rx<String?>(adminCode);
    update();
  }

  bool hasDate() {
    return _drawDateYear.value! >= 2025 &&
        _drawDateMonth.value! > 0 &&
        _drawDateDay.value! > 0;
  }

  bool hasTime() {
    return _drawDateHour.value! >= 0 && _drawDateMinute.value! >= 0;
  }

  bool hasGrandPrice(int memberIndex) {
    switch (memberIndex) {
      case 1:
        return _drawGrandPrice1ImageFile.value != null &&
            _grandPrice1ImageURL.value != null &&
            _description1.value != null;
      case 2:
        return _drawGrandPrice2ImageFile.value != null &&
            _grandPrice2ImageURL.value != null &&
            _description2.value != null;
      case 3:
        return _drawGrandPrice3ImageFile.value != null &&
            _grandPrice3ImageURL.value != null &&
            _description3.value != null;
      case 4:
        return _drawGrandPrice4ImageFile.value != null &&
            _grandPrice4ImageURL.value != null &&
            _description4.value != null;
      default:
        return _drawGrandPrice5ImageFile.value != null &&
            _grandPrice5ImageURL.value != null &&
            _description5.value != null;
    }
  }

  void setDate(int year, int month, int day) {
    _drawDateYear = Rx<int?>(year);
    _drawDateMonth = Rx<int?>(month);
    _drawDateDay = Rx<int?>(day);
    update();
  }

  void setTime(int hour, int minute) {
    _drawDateHour = Rx<int?>(hour);
    _drawDateMinute = Rx<int?>(minute);
    update();
  }

  void setGrandPriceToWinIndex(int index) {
    _grandPriceToWinIndex = Rx(index);
    update();
  }

  // Supposed To Be A Backend Function.
  Future<HostedDrawSavingStatus> createHostedDraw() async {
    if (_adminCode.value!.compareTo('$drawKeyPart@NUZ') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@MUT') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@DUT') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@MAYV') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@SYD') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@UKZN') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@DBNC') != 0 &&
        _adminCode.value!.compareTo('$drawKeyPart@NANDA') != 0) {
      return HostedDrawSavingStatus.loginRequired;
    } else if (!hasDate()) {
      getSnapbar('Error', 'Date Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    if (!hasTime()) {
      getSnapbar('Error', 'Time Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    if (!hasGrandPrice(1)) {
      getSnapbar('Error', 'First Price Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    if (!hasGrandPrice(2)) {
      getSnapbar('Error', 'Second Price Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    if (!hasGrandPrice(3)) {
      getSnapbar('Error', 'Third Price Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    if (!hasGrandPrice(4)) {
      getSnapbar('Error', 'Forth Price Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    if (!hasGrandPrice(5)) {
      getSnapbar('Error', 'Fifth Price Info Missing.');
      return HostedDrawSavingStatus.incomplete;
    }

    String hostedDrawId =
        '${_drawDateYear.value}-${_drawDateMonth.value}-${_drawDateDay.value}@${_drawDateHour.value}h${_drawDateMinute.value}@${hostingArea!.hostingAreaId}';
    DocumentReference reference = firestore
        .collection('hosting_areas')
        .doc(hostingArea!.hostingAreaId)
        .collection('hosted_draws')
        .doc(hostedDrawId);

    // FieldValue.serverTimestamp();

    HostedDraw hostedDraw = HostedDraw(
      hostedDrawId: reference.id,
      groupToWinId: groupToWinId!,
      hostingAreaFK: hostingAreaController.hostingArea!.hostingAreaId,
      groupToWinPhoneNumber: groupToWinPhoneNumber!,
      drawDateAndTime: DateTime(
        hostingAreaController.drawDateYear!,
        hostingAreaController.drawDateMonth!,
        hostingAreaController.drawDateDay!,
        hostingAreaController.drawDateHour!,
        hostingAreaController.drawDateMinute!,
      ),
      numberOfGrandPrices: 5,
      grandPriceToWinIndex: _grandPriceToWinIndex.value!,
      hostingAreaName: hostingAreaController.hostingArea!.hostingAreaName,
      hostingAreaImageURL:
          hostingAreaController.hostingArea!.hostingAreaImageURL,
      townOrInstitution: Converter.toSupportedTownOrInstitution(
        hostingAreaController.hostingArea!.sectionName,
      ),
    );

    await reference.set(hostedDraw.toJson());

    await _saveDrawGrandPrice(hostedDraw.hostedDrawId!, 0);
    await _saveDrawGrandPrice(hostedDraw.hostedDrawId!, 1);
    await _saveDrawGrandPrice(hostedDraw.hostedDrawId!, 2);
    await _saveDrawGrandPrice(hostedDraw.hostedDrawId!, 3);
    await _saveDrawGrandPrice(hostedDraw.hostedDrawId!, 4);

    DocumentReference hostInfoReference = firestore
        .collection("hosts_info")
        .doc(hostedDraw.hostingAreaFK);

    hostInfoReference.get().then((hostInfoDoc) async {
      HostInfo info = HostInfo.fromJson(hostInfoDoc.data());
      info.drawsOrder!.add(hostedDrawId);
      await hostInfoReference.update({'drawsOrder': info.drawsOrder!});
      debug.log('added to draws order list...');
    });

    await hostInfoReference.update({
      'latestHostedDrawId': hostedDraw.hostedDrawId,
    });

    return HostedDrawSavingStatus.saved;
  }

  /*===========================Store Draws [End]====================== */

  /*======================Draw Grand Price[Start]===================== */

  Future<void> _saveDrawGrandPrice(
    String hostedDrawFK,
    int grandPriceIndex,
  ) async {
    late String imageURL;
    late String description;

    switch (grandPriceIndex) {
      case 0:
        imageURL = trimmedImageURL(0);
        description = _description1.value!;
        break;
      case 1:
        imageURL = trimmedImageURL(1);
        description = _description2.value!;
        break;
      case 2:
        imageURL = trimmedImageURL(2);
        description = _description3.value!;
        break;
      case 3:
        imageURL = trimmedImageURL(3);
        description = _description4.value!;
        break;
      default:
        imageURL = trimmedImageURL(4);
        description = _description5.value!;
    }

    DocumentReference reference = firestore
        .collection('hosting_areas')
        .doc(hostingArea!.hostingAreaId)
        .collection('hosted_draws')
        .doc(hostedDrawFK)
        .collection('draw_grand_prices')
        .doc('$hostedDrawFK-$grandPriceIndex');

    DrawGrandPrice drawGrandPrice = DrawGrandPrice(
      grandPriceId: reference.id,
      hostedDrawFK: hostedDrawFK,
      imageURL: imageURL,
      description: description,
      grandPriceIndex: grandPriceIndex,
    );

    await reference.set(drawGrandPrice.toJson());
  }

  // Branch : competition_resources_crud ->  competitions_data_access
  Stream<List<DrawGrandPrice>> findDrawGrandPrices(
    String hostingAreaId,
    String hostedDrawId,
  ) => FirebaseFirestore.instance
      .collection('hosting_areas')
      .doc(hostingAreaId)
      .collection('hosted_draws')
      .doc(hostedDrawId)
      .collection('draw_grand_prices')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map((doc) => DrawGrandPrice.fromJson(doc.data()))
            .toList(),
      );

  /*======================Draw Grand Price[End]============================ */

  /*======================Notification Start]============================ */
  Future<NoticeSavingStatus> saveNotice(
    String message,
    List<String> audience, {
    bool forAll = false,
    DateTime? endTime,
  }) async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null || user is my.User) {
      getSnapbar('Saving Failed', 'Admin Logging Required.');
      return NoticeSavingStatus.adminLoginRequired;
    } else if (message.isEmpty || (audience.isEmpty && !forAll)) {
      getSnapbar('Saving Failed', 'Incomplete Info.');
      return NoticeSavingStatus.incomplete;
    } else {
      DocumentReference reference = firestore.collection('notifications').doc();

      Notification notification = Notification(
        notificationId: reference.id,
        creatorPhoneNumber: user.phoneNumber,
        message: message,
        audience: audience,
        endDate: endTime ?? DateTime.now().add(const Duration(days: 7)),
        forAll: forAll,
      );

      await reference.set(notification.toJson());
      return NoticeSavingStatus.saved;
    }
  }

  void arrayUpdate() {
    DocumentReference reference = firestore.collection('notifications').doc();

    reference.update({'dateCreated': FieldValue.serverTimestamp()});

    reference.update({
      'data': FieldValue.arrayRemove(['date']),
    });
    reference.update({
      'data': FieldValue.arrayUnion(['date']),
    });

    reference.update({'data': FieldValue.increment(3)});
  }

  void setGroupToWin(String groupToWinPhoneNumberAndId) {
    final array = groupToWinPhoneNumberAndId.split(' ');

    _groupToWinId = Rx(array[1]);
    debug.log('Group To Win Id ${groupToWinId}');
    _groupToWinPhoneNumber = Rx(array[0]);
    debug.log('Group To Win Phone Number ${groupToWinPhoneNumber}');
    update();
  }
}
