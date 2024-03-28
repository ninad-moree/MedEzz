import 'package:flutter/material.dart';
import 'package:medezz/api/patient/profile/view_profile.dart';
import 'package:medezz/screens/doctor_patient/doctor_patient.dart';
import 'package:medezz/services/zego_login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import 'widget/info_tile.dart';

class ProfileScreenPatient extends StatefulWidget {
  const ProfileScreenPatient({super.key});

  @override
  State<ProfileScreenPatient> createState() => _ProfileScreenPatientState();
}

class _ProfileScreenPatientState extends State<ProfileScreenPatient> {
  late PatientProfile profile = PatientProfile(username: '', email: '', id: '');

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    PatientProfile prof = await viewProfile();
    setState(() {
      profile = prof;
    });
  }

  void _removeToken() async {
    onUserLogout();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const ClipOval(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 60,
                  child: Image(
                    image: AssetImage("assets/images/user2.jpg"),
                  ),
                ),
              ),
            ),
          ),
          InfoTile(
            tileName: "User name :",
            content: profile.username,
            icon: Icons.person,
          ),
          // const InfoTile(
          //   tileName: "Last name :",
          //   content: "More",
          //   icon: Icons.person,
          // ),
          InfoTile(
            tileName: "Email :",
            content: profile.email,
            icon: Icons.email,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 60,
            width: double.infinity,
            color: Colors.grey,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "L O G O U T",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      _removeToken();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorPatient(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.logout,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
