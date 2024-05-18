// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medezz/constants/colors.dart';
import 'package:medezz/screens/doctor/authentication/login/login_screen_doctor.dart';
import 'package:medezz/screens/patient/authentication/login/login_screen.dart';
import 'package:medezz/screens/patient/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorPatient extends StatelessWidget {
  const DoctorPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SignUp as Doctor',
                    style: TextStyle(
                      fontSize: 24,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/docto.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreenDoctor(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(7, 82, 96, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "Doctor",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Color.fromRGBO(7, 82, 96, 1)),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SignUp as Patient',
                    style: TextStyle(
                      fontSize: 24,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/patient.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        bool? isLogin = prefs.getBool('isLoggedIn') ?? false;

                        if (isLogin) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                            (route) => false,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreenPatient(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(7, 82, 96, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        "Patient",
                        style: TextStyle(color: Colors.white),
                      ),
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
