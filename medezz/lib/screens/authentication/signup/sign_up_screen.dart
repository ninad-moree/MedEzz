import 'package:flutter/material.dart';

import 'widget/sign_up_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              const SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
