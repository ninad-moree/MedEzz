import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../api/doctor/appointments/get_appointments.dart';
import '../../../api/doctor/model/appointment.dart';
import '../../../constants/colors.dart';
import '../profile/doctor_profile.dart';
import 'widgets/appointment_list_tile.dart';

enum States { loading, noAppointments, loaded, error }

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  States _state = States.loading;
  List<Appointment> appointments = [];

  @override
  void initState() {
    getAppointmentsData();
    super.initState();
  }

  void getAppointmentsData() async {
    http.Response response = await getAppointments();
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        appointments = (jsonDecode(response.body) as List).map((e) => Appointment.fromJson(e)).toList();
        if (appointments.isEmpty) {
          _state = States.noAppointments;
        } else {
          _state = States.loaded;
        }
      });
      log(appointments.toString());
    } else {
      setState(() {
        _state = States.error;
      });
    }
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
            return ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: AppointmentListTile(
                    appointment: appointments[index],
                  ),
                );
              },
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
