import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/user_controller.dart';
import 'controllers/admin_controller.dart';
import 'controllers/competition_controller.dart';
import 'controllers/language_controller.dart';
import 'controllers/location_controller.dart';

import 'controllers/hosting_area_controller.dart';
import 'controllers/group_controller.dart';

import 'controllers/shared_resources_controller.dart';
import 'firebase_options.dart';
import 'screens/utils/start_screen.dart';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

// Branching Strategy - Trunk-Based Dev
/* 

  ***********To Find Start***********

  ***********To Find End***********

  ***********Phone Numbers Start***********
   Njabulo 0835367834
   Math tutor 0728044157

   Esethu 0652488394
   Mafungwashe, 0766915230
   Majali 0823201656
   sbali 0822131294
   Bosh 0744127814
   Tata 0714294940
   Mahlaba 0691203923
   
   Hope  0609934978/0637395543
   Mkeboz 0658040676
   mayise 0725704960
   Bantu 0664437968
   Caleka 0780789053
   
   wits boi sanele 0768019418
   
   
   ***********Phone Numbers End***********
*/

void prepareControllers(bucket) {
  final firestore = FirebaseFirestore.instance;
  final functions = FirebaseFunctions.instance;
  final storage =
      FirebaseStorage
          // .instance.ref();
          .instanceFor(bucket: bucket)
          .ref();

  final auth = FirebaseAuth.instance;

  Get.put(LanguageController());
  Get.put(
    UserController(
      firestore: firestore,
      functions: functions,
      storage: storage,
      auth: auth,
    ),
  );
  Get.put(
    AdminController(
      firestore: firestore,
      functions: functions,
      storage: storage,
      auth: auth,
    ),
  );

  Get.put(
    LocationController(
      firestore: firestore,
      functions: functions,
      storage: storage,
      auth: auth,
    ),
  );

  Get.put(
    GroupController(
      firestore: firestore,
      functions: functions,
      storage: storage,
      auth: auth,
    ),
  );

  Get.put(
    HostingAreaController(
      firestore: firestore,
      functions: functions,
      storage: storage,
      auth: auth,
    ),
  );
  Get.put(
    CompetitionController(
      firestore: firestore,
      functions: functions,
      storage: storage,
      auth: auth,
    ),
  );
  Get.put(SharedResourcesController());
}

// Testing framework(mocha) not yet intalled.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    prepareControllers("gs://wow-we-won.firebasestorage.app");
  });
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose .
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    // appleProvider: AppleProvider.appAttest,
  );
  /*
  // Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
  await FirebaseStorage //.instance
      .instanceFor(bucket: "gs://alco-prod-45f94.firebasestorage.app")
      .useStorageEmulator('127.0.0.1', 9199);
  FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
  FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080); */

  runApp(MyApplication());
}

class MyApplication extends StatefulWidget {
  MyApplication({super.key});

  static String title = '';

  static double backArrowFontSize = 20;
  static Color backArrowColor = Colors.blue;
  static double backArrowTitleFontSize = 14;
  static Color backArrowTitleColor = Colors.pink;

  static EdgeInsets storeDataPadding = const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 10,
  );

  //static Color scaffoldColor = const Color.fromARGB(240, 23, 212, 212);
  static Color scaffoldColor = const Color.fromARGB(31, 1, 24, 24);

  static Color scaffoldBodyColor = const Color.fromARGB(255, 173, 235, 229);

  static Color attractiveColor1 = Colors.pink;
  static Color attractiveColor2 = Colors.purple;

  static LinearGradient priceslinearGradient = const LinearGradient(
    colors: [Colors.white, Color.fromARGB(255, 44, 35, 46)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static Color textColor = const Color.fromARGB(255, 154, 46, 173);
  static double infoTextFontSize = 15;

  static Color storeInfoTextColor = Colors.lightBlue;
  //static Color storeInfoTextColor = const Color.fromARGB(169, 27, 3, 114);

  static Color storesTextColor = const Color.fromARGB(255, 40, 236, 210);
  static Color storesSpecialTextColor = const Color.fromARGB(255, 244, 3, 184);

  //static Color headingColor = const Color.fromARGB(169, 106, 3, 124);

  static Color logoColor1 = Colors.green;
  static Color logoColor2 = Colors.blue;

  static String userPhoneNumber = '';

  static BoxDecoration userThoughtsAreaDecoration = const BoxDecoration(
    color: Color.fromARGB(255, 190, 183, 209),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
  );

  static BoxDecoration userThoughtsDecoration = const BoxDecoration(
    color: Color.fromARGB(255, 182, 142, 189),
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );

  static TextStyle usernameStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static TextStyle userMessageStyle = const TextStyle(
    color: Colors.blueGrey,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static double playCompetitionIconFontSize = 75;
  static double alarmIconFontSize = 60;

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  void initState() {
    // This method execute only when this state is created for the first time.
    // It get executed befor the build method.
    super.initState();
    // whenever your initialization is completed, remove the splash screen:
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wow',
        theme: ThemeData(
          primaryColor: const Color.fromARGB(115, 231, 195, 214),
          secondaryHeaderColor: const Color.fromARGB(115, 231, 195, 214),
        ),
        home: StartScreen(),

        // Make sure to create a draw given there are groups belonging to the host's location.
      ),
    );
  }
}
