import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medezz/screens/patient/authentication/login/widget/login_form.dart';
import 'package:medezz/screens/patient/authentication/login/widget/login_header.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/patient/authentication/login_patient.dart';
import '../../../../api/patient/profile/view_profile.dart';
import '../../../../services/zego_login_services.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../main_page.dart';

class LoginScreenPatient extends StatefulWidget {
  const LoginScreenPatient({super.key});

  @override
  State<LoginScreenPatient> createState() => _LoginScreenPatientState();
}

class _LoginScreenPatientState extends State<LoginScreenPatient> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(7, 82, 96, 1),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Login Header
                const LoginHeader(),

                // Login Form
                const LoginFormPatient(),

                ElevatedButton(
                  onPressed: () async {
                    UserCredential? creds = await signInWithGoogle();

                    log("Google Id: $creds");

                    Map<String, dynamic> res = await loginPatient(
                      creds!.user!.email ?? "peeyush.kulgude777@gmail.com",
                      "12345678",
                    );

                    int statusCode = res['statusCode'];
                    if (statusCode == 200 || statusCode == 201) {
                      storeToken(res['accessToken']);

                      log('Access Token:');
                      log(res['accessToken']);

                      PatientProfile prof = await viewProfile();

                      log("Profile");
                      log(prof.toString());

                      onUserLogin(
                        myUserId: prof.id,
                        myUserName: prof.username,
                        context: context,
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                        (route) => false,
                      );

                      var status = await Permission.activityRecognition.status;
                      var status1 = await Permission.sensorsAlways.status;

                      if (status.isGranted) {
                        // Permission is already granted
                        print('Activity recognition permission is granted.');
                      } else {
                        // Permission is not granted, request it
                        var result = await Permission.activityRecognition.request();

                        if (result.isGranted) {
                          // Permission granted
                          print('Activity recognition permission is granted.');
                        } else {
                          // Permission denied
                          print('Activity recognition permission is denied.');
                        }
                      }

                      if (status1.isGranted) {
                        // Permission is already granted
                        print('Activity recognition permission is granted.');
                      } else {
                        // Permission is not granted, request it
                        var result = await Permission.sensorsAlways.request();

                        if (result.isGranted) {
                          // Permission granted
                          print('Activity recognition permission is granted.');
                        } else {
                          // Permission denied
                          print('Activity recognition permission is denied.');
                        }
                      }
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
                  child: const Text("Google Sign In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
