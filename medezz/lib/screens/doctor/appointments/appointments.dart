import 'package:flutter/material.dart';

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
