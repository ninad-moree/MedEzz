import 'package:flutter/material.dart';
import 'package:medezz/screens/onboarding/on_boarding.dart';

import 'screens/notifications/Services/notification_services.dart';

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
  [log] button pressed
  [log] ninad183more - username
  [log] ninad183 - pwd
  [log] ninad183@gmail.com - email
  [log] Patient Registered Succesfully
  [log] {"_id":"6600231938e760e407da8e8f","email":"ninad183@gmail.com "}
  [log] 201
*/