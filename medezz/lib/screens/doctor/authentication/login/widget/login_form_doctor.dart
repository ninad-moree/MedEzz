// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medezz/api/doctor/authentication/login_doctor.dart';
import 'package:medezz/api/doctor/profile/doctor_profile.dart';
import 'package:medezz/screens/doctor/authentication/signup/signup_screen_doctor.dart';
import 'package:medezz/screens/doctor/main_page.dart';
import 'package:medezz/services/zego_login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../widgets/custom_snackbar.dart';

class LoginFormDoctor extends StatelessWidget {
  const LoginFormDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void storeToken(String token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('docToken', token);
    }

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            // EMAIL
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: "E-Mail",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // PASSWORD
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.eye_slash),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // SIGN IN BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> res = await loginDoctor(
                    emailController.text,
                    passwordController.text,
                  );

                  int statusCode = res['statusCode'];
                  if (statusCode == 200 || statusCode == 201) {
                    storeToken(res['accessToken']);

                    DoctorProfile docProfile = await viewDoctorProfile();

                    onUserLogin(
                      myUserId: docProfile.id,
                      myUserName: docProfile.username,
                      context: context,
                    );

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                      (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: ShowCustomSnackBar(
                        title: "Something Went Wrong",
                        label: 'Wrong Information Provided. Try Again',
                        color: Colors.red,
                        icon: Icons.warning_rounded,
                      ),
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(7, 82, 96, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // CREATE ACCOUNT BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreenDoctor(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    color: Color.fromRGBO(7, 82, 96, 1),
                    width: 1,
                  ),
                ),
                child: const Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
