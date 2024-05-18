// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:developer';
import '../../../../../api/patient/authentication/signup_patient.dart';
import '../../../../../widgets/custom_snackbar.dart';

class SignupFormPatient extends StatefulWidget {
  const SignupFormPatient({super.key});

  @override
  State<SignupFormPatient> createState() => _SignupFormPatientState();
}

class _SignupFormPatientState extends State<SignupFormPatient> {
  @override
  Widget build(BuildContext context) {
    bool isObscured = true;
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Form(
      child: Column(
        children: [
          //USERNAME
          TextFormField(
            controller: usernameController,
            expands: false,
            decoration: InputDecoration(
              labelText: "Username",
              prefixIcon: const Icon(Iconsax.user_edit),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          const SizedBox(height: 32),

          //EMAIl
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: const Icon(Iconsax.direct),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          const SizedBox(height: 32),

          //PASSWORD
          TextFormField(
            controller: passwordController,
            obscureText: isObscured,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Iconsax.password_check),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  isObscured == true ? Iconsax.eye_slash : Iconsax.eye,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          //SIGN UP BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                log("button pressed");
                log(usernameController.text);
                log(passwordController.text);
                log(emailController.text);

                int res = await signUpPatient(
                  usernameController.text,
                  emailController.text,
                  passwordController.text,
                );

                if (res == 200 || res == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: ShowCustomSnackBar(
                      title: "Account Created",
                      label: 'Go Back and Login.',
                      color: Colors.green,
                      icon: Icons.done_outlined,
                    ),
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: ShowCustomSnackBar(
                      title: "Something Went Wrong",
                      label: 'User Already Exists or Wrong Information',
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
                "Create Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
