import 'package:flutter/material.dart';
import 'package:medezz/api/doctor/profile/doctor_profile.dart';
import 'package:medezz/screens/doctor_patient/doctor_patient.dart';
import 'package:medezz/services/zego_login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../patient/profile/widget/info_tile.dart';

class ProfileScreenDoctor extends StatefulWidget {
  const ProfileScreenDoctor({super.key});

  @override
  State<ProfileScreenDoctor> createState() => _ProfileScreenDoctorState();
}

class _ProfileScreenDoctorState extends State<ProfileScreenDoctor> {
  late DoctorProfile profile = DoctorProfile(username: '', email: '', id: '');

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    DoctorProfile prof = await viewDoctorProfile();
    setState(() {
      profile = prof;
    });
  }

  void _removeToken() async {
    onUserLogout();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('docToken');
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
                  backgroundColor: Colors.grey,
                  radius: 60,
                  child: Image(
                    image: AssetImage("assets/images/doctors/doc3.png"),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await viewDoctorProfile();
            },
            child: InfoTile(
              tileName: "User name :",
              content: profile.username,
              icon: Icons.person,
            ),
          ),
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
