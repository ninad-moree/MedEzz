import 'package:flutter/material.dart';
import 'package:medezz/screens/doctor/authentication/signup/widget/signup_form_doctor.dart';

class SignupScreenDoctor extends StatelessWidget {
  const SignupScreenDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TITLE
              Text(
                "Let's create your account.",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 32),

              // FORM
              const SignupFormDoctor(),
            ],
          ),
        ),
      ),
    );
  }
}
