import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage('assets/icon_small.png'),
        ),
        Text(
          "Welcome back,",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(7, 82, 96, 1),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Find Your Perfect Doctor and Stay  Healthy!",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(7, 82, 96, 1),
          ),
        ),
      ],
    );
  }
}
