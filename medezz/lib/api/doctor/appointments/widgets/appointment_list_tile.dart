import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medezz/screens/doctor/patient_appointment_details/patient_appointment_details.dart';

import '../../model/appointment.dart';

class AppointmentListTile extends StatelessWidget {
  final Appointment appointment;

  const AppointmentListTile({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(appointment.patientName[0]),
      ),
      title: Text(appointment.patientName),
      subtitle: Text(
        'Date: ${DateFormat('dd/MM/yyyy').format(appointment.date)}\nTime: ${DateFormat('hh:mm').format(appointment.date)}',
      ),
      trailing: const Icon(Icons.wifi),
      onTap: () {
        log("card tapped");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientAppointmentDetails(
              patientId: appointment.patientId,
            ),
          ),
        );
      },
    );
  }
}
