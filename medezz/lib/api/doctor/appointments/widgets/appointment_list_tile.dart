import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medezz/api/doctor/appointments_details/add_notes.dart';

import '../../../../constants/colors.dart';
import '../../../../screens/doctor/patient_appointment_details/patient_appointment_details.dart';
import '../../model/appointment.dart';

class AppointmentListTile extends StatelessWidget {
  final Appointment appointment;

  const AppointmentListTile({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientAppointmentDetails(
              patientId: appointment.patientId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              CircleAvatar(child: Text(appointment.patientName[0])),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.patientName),
                    Text(
                      "Date: ${DateFormat('dd/MM/yyyy').format(appointment.date)}",
                    ),
                    Text(
                      "Time: ${DateFormat('hh:mm').format(appointment.date)}",
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        log(appointment.appointmentId);
                        //TODO: On Pressed - New Custom Box to Add a note and then on submit call api
                        await addNotes(
                          "Patient Note Added",
                          appointment.appointmentId,
                          appointment.patientId,
                        );
                      },
                      child: Container(
                        height: 20,
                        width: 70,
                        decoration: BoxDecoration(
                          color: CustomColors.customGrey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Center(
                          child: Text(
                            'Add Notes',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Icon(Icons.wifi),
            ],
          ),
        ),
      ),
    );
    // return ListTile(
    // leading: CircleAvatar(
    //   child: Text(appointment.patientName[0]),
    // ),
    //   title: Text(appointment.patientName),
    //   subtitle: Text(
    //     'Date: ${DateFormat('dd/MM/yyyy').format(appointment.date)}\nTime: ${DateFormat('hh:mm').format(appointment.date)}',
    //   ),
    //   trailing: const Icon(Icons.wifi),
    //   onTap: () {
    //     log("card tapped");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PatientAppointmentDetails(
    //       patientId: appointment.patientId,
    //     ),
    //   ),
    // );
    //   },
    // );
  }
}
