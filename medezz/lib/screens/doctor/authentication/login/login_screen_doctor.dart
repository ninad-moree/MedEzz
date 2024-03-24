import 'package:flutter/material.dart';
import 'package:medezz/screens/doctor/authentication/login/widget/login_form_doctor.dart';
import 'package:medezz/screens/doctor/authentication/login/widget/login_header_doctor.dart';

class LoginScreenDoctor extends StatefulWidget {
  const LoginScreenDoctor({super.key});

  @override
  State<LoginScreenDoctor> createState() => _LoginScreenDoctorState();
}

class _LoginScreenDoctorState extends State<LoginScreenDoctor> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                // Login Header
                LoginHeaderDoctor(),

                // Login Form
                LoginFormDoctor(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
