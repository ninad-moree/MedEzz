import 'package:flutter/material.dart';
import 'package:medezz/screens/doctor/profile/doctor_profile.dart';

import '../../../api/doctor/appointments/get_appointments.dart';
import '../../../constants/colors.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenDoctor(),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Appt"),
          onPressed: () async {
            await getAppointments();
          },
        ),
      ),
    );
  }
}
