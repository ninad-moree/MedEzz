import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../authentication/login/login_screen.dart';
import 'widget/info_tile.dart';

class ProfileScreenPatient extends StatelessWidget {
  const ProfileScreenPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: const ClipOval(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    child: Image(
                      image: AssetImage("assets/images/user2.jpg"),
                    ),
                  ),
                ),
              ),
            ),
            const InfoTile(
              tileName: "First name :",
              content: "Ninad",
              icon: Icons.person,
            ),
            const InfoTile(
              tileName: "Last name :",
              content: "More",
              icon: Icons.person,
            ),
            const InfoTile(
              tileName: "Email :",
              content: "ninad18@gmail.com",
              icon: Icons.email,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              height: 60,
              width: double.infinity,
              color: Colors.grey,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreenPatient(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Icon(
                        Icons.logout,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
