import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:developer';
import '../../../../api/authentication/signup_patient.dart';
import 'terms_and_conditions_checkbox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // FIRST NAME AND LASTNAME
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    prefixIcon: const Icon(Iconsax.user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: const Icon(Iconsax.user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),

          const SizedBox(height: 32),

          //USERNAME
          TextFormField(
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
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: const Icon(Iconsax.direct),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          const SizedBox(height: 32),

          //PHONE NUMBER
          TextFormField(
            decoration: InputDecoration(
              labelText: "Phone Number",
              prefixIcon: const Icon(Iconsax.call),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          const SizedBox(height: 32),

          //PASSWORD
          TextFormField(
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Iconsax.password_check),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.eye_slash),
              ),
            ),
          ),

          const SizedBox(height: 32),

          //TERMS AND CONDITIONS CHECKBOX
          const TermsAndConditionsCheckBox(),

          const SizedBox(height: 32),

          //SIGN UP BUTTON
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                log("button pressed");
                await signUpPatient("Ninad", "ninad@gmail.com", "ninad18");
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
