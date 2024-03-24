import 'package:flutter/material.dart';
import 'package:medezz/screens/onboarding/on_boarding.dart';

import 'screens/patient/notifications/Services/notification_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromRGBO(241, 250, 251, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 241, 250, 251),
        ),
        colorSchemeSeed: const Color.fromRGBO(7, 82, 96, 1),
      ),
      home: const OnBoardingScreen(),
    );
  }
}


/*
  [log] ninadM - username
  [log] ninad18 - pwd
  [log] ninad18@gmail.com - gmail
  [log] Patient Registered Succesfully
  [log] {"_id":"66002b220d379f3ff1d6cfff","email":"ninad18@gmail.com"}

  [log] doctor2
  [log] doctor123
  [log] doc@gmail.com
  [log] Doctor Registered Succesfully
  [log] {"_id":"66004b950cafd24689cebb09","email":"doc@gmail.com"}
*/