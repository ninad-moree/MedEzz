import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:medezz/constants/colors.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/patient/profile/view_patient_profile.dart';
import '../../../api/patient/profile/view_profile.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PlantScreenState createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  Artboard? _riveArtboard;
  // ignore: unused_field
  StateMachineController? _controller;
  SMIInput<double>? _progress;
  String plantButtonText = "";
  int treeProgress = 0;
  final int _treeMaxProgress = 60;
  PatientProfile profile = PatientProfile(username: "", email: "", id: "");

  @override
  void initState() {
    super.initState();
    viewPersonProfile();
    plantButtonText = "Plant";
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/tree_demo.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'Grow');
        if (controller != null) {
          artboard.addController(controller);
          _progress = controller.findInput('input');
          _progress?.value = treeProgress.toDouble();
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  Future<dynamic> viewPersonProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final http.Response response = await http.get(
      Uri.parse("https://healthlink-backend.onrender.com/patient/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("View Patient Profile Success");
      log(response.statusCode.toString());
      log(response.body);

      log("View Patient Profile Success");
      log(response.body);

      int medicineStreak = int.parse(jsonDecode(response.body)["streaks"]["medicine"].toString());
      int waterStreak = int.parse(jsonDecode(response.body)["streaks"]["water"].toString());
      int stepsStreak = int.parse(jsonDecode(response.body)["streaks"]["steps"].toString());
      int calorieStreak = int.parse(jsonDecode(response.body)["streaks"]["calories"].toString());
      int sleepStreak = int.parse(jsonDecode(response.body)["streaks"]["sleep"].toString());

      setState(() {
        treeProgress = medicineStreak + waterStreak + stepsStreak + calorieStreak + sleepStreak;
        Future.delayed(const Duration(seconds: 1), () {
          _progress?.value = treeProgress.toDouble() * 7;
        });
      });
    } else {
      log("View Patient Profile Failure");
      log(response.statusCode.toString());
      log(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    double treeWidth = MediaQuery.of(context).size.width - 40;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Text(
              "Green Streak!",
              style: TextStyle(
                color: CustomColors.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _riveArtboard == null
                  ? const SizedBox()
                  : Container(
                      width: treeWidth,
                      height: treeWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(treeWidth / 2),
                        border: Border.all(
                          color: CustomColors.primaryColor,
                          width: 5,
                        ),
                      ),
                      child: Rive(
                        alignment: Alignment.center,
                        artboard: _riveArtboard!,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              "Congratulations on a $treeProgress day streak!",
              style: const TextStyle(
                color: CustomColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
