import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:medezz/api/patient/profile/view_profile.dart';
import 'package:medezz/constants/api_constants.dart';
import 'package:medezz/screens/onboarding/on_boarding.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'firebase_options.dart';
import 'screens/patient/notifications/Services/notification_services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// checking
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  Gemini.init(apiKey: ApiConstants.geminiAPI);

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.navigatorKey,
  });

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PatientProfile patientProfile =
      PatientProfile(username: '', email: '', id: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedEzz',
      navigatorKey: widget.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromRGBO(241, 250, 251, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 241, 250, 251),
        ),
        colorSchemeSeed: const Color.fromRGBO(7, 82, 96, 1),
      ),
      // home: const OnBoardingScreen(),
      initialRoute: '/',
      routes: {'/': (context) => const OnBoardingScreen()},
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,

            //  support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return widget.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
    );
  }
}


/*
  [log] ninadM - username
  [log] ninad18 - pwd
  [log] ninad18@gmail.com - gmail
  [log] Patient Registered Succesfully
  [log] {"_id":"66002b220d379f3ff1d6cfff","email":"ninad18@gmail.com"}

  [log] doctor2 - username
  [log] doctor123 - pwd
  [log] doc@gmail.com - gmail
  [log] Doctor Registered Succesfully
  [log] {"_id":"66004b950cafd24689cebb09","email":"doc@gmail.com"}

  "email": "dr_kumar@example.com",
  "password": "securepass789",

  [log] ninad183
  [log] 12345
  [log] ninad183@gmail.com
*/