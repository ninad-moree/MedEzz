import 'package:flutter/material.dart';
import 'package:medezz/screens/doctor/profile/doctor_profile.dart';

import '../../../api/doctor/appointments/get_appointments.dart';
import '../../../constants/colors.dart';

enum States { loading, noAppointments, loaded }

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final States _state = States.loading;

  @override
  void initState() {
    getAppointments();
    super.initState();
  }

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
      body: Builder(
        builder: (context) {
          if (_state == States.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColors.primaryColor,
              ),
            );
          } else if (_state == States.noAppointments) {
            return const Center(
              child: Text("No appointments"),
            );
          } else if (_state == States.loaded) {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          } else {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
