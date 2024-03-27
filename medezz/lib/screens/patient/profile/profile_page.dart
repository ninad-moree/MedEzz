import 'package:flutter/material.dart';
import 'package:medezz/screens/patient/authentication/login/login_screen.dart';

import '../../../constants/colors.dart';

class ProfileScreenPatient extends StatelessWidget {
  const ProfileScreenPatient({super.key});

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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreenPatient(),
              ),
              (route) => false,
            );
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
