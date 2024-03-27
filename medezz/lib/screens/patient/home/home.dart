import 'package:flutter/material.dart';
import 'package:medezz/constants/colors.dart';
import 'package:medezz/screens/patient/profile/profile_page.dart';

class HomeScreenPatient extends StatefulWidget {
  const HomeScreenPatient({super.key});

  @override
  State<HomeScreenPatient> createState() => _HomeScreenPatientState();
}

class _HomeScreenPatientState extends State<HomeScreenPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenPatient(),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
        title: const Text(
          'Doctors',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
