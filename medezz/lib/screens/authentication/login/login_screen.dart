import 'package:flutter/material.dart';
import 'package:medezz/screens/authentication/login/widget/login_form.dart';
import 'package:medezz/screens/authentication/login/widget/login_header.dart';

class LoginScreenPatient extends StatefulWidget {
  const LoginScreenPatient({super.key});

  @override
  State<LoginScreenPatient> createState() => _LoginScreenPatientState();
}

class _LoginScreenPatientState extends State<LoginScreenPatient> {
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
                LoginHeader(),

                // Login Form
                LoginFormPatient(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
