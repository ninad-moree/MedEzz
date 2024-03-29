import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medezz/api/doctor/appointments_details/add_notes.dart';
import 'package:medezz/api/doctor/appointments_details/reschudle_appointments.dart';

import '../../../../constants/colors.dart';
import '../../../../screens/doctor/patient_appointment_details/patient_appointment_details.dart';
import '../../model/appointment.dart';

class AppointmentListTile extends StatefulWidget {
  final Appointment appointment;

  const AppointmentListTile({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<AppointmentListTile> createState() => _AppointmentListTileState();
}

class _AppointmentListTileState extends State<AppointmentListTile> {
  // DateTime _selectedDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientAppointmentDetails(
              patientId: widget.appointment.patientId,
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
              CircleAvatar(child: Text(widget.appointment.patientName[0])),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.appointment.patientName),
                    Text(
                      "Date: ${DateFormat('dd/MM/yyyy').format(widget.appointment.date)}",
                    ),
                    Text(
                      "Time: ${DateFormat('hh:mm').format(widget.appointment.date)}",
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            log(widget.appointment.appointmentId);
                            //TODO: On Pressed - New Custom Box to Add a note and then on submit call api
                            await addNotes(
                              "Patient Note Added",
                              widget.appointment.appointmentId,
                              widget.appointment.patientId,
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
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Select a Date'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text('Please select a date:'),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: selectedDate,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 5),
                                            );
                                            if (pickedDate != null) {
                                              setState(() {
                                                selectedDate = pickedDate;
                                                log(selectedDate.toString());
                                              });
                                            }
                                          },
                                          child: const Text("Select Date"),
                                          // child: Text(
                                          //   "Select Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}",
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await rescheduleAppointment(
                                          selectedDate,
                                          widget.appointment.appointmentId,
                                          widget.appointment.patientId,
                                        );
                                        log('Selected Date: $selectedDate');
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 20,
                            width: 90,
                            decoration: BoxDecoration(
                              color: CustomColors.customGrey,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Center(
                              child: Text(
                                'Reschedule',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
  }
}
