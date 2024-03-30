// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medezz/api/doctor/appointments_details/add_notes.dart';
import 'package:medezz/api/doctor/appointments_details/reschudle_appointments.dart';

import '../../../../constants/colors.dart';
import '../../../../screens/doctor/patient_appointment_details/patient_appointment_details.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../appointments_details/add_medication.dart';
import '../../appointments_details/add_threshhold.dart';
import '../../appointments_details/appointement_details.dart';
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
                        Column(
                          children: [
                            // Add Note
                            GestureDetector(
                              onTap: () async {
                                log(widget.appointment.appointmentId);
                                final TextEditingController note =
                                    TextEditingController();

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          CustomColors.primaryColor,
                                      content: SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.75,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Add Your Notes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: TextFormField(
                                                controller: note,
                                                maxLines: 5,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      "Add Your Note Here.",
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () async {
                                                int res = await addNotes(
                                                  // "Patient Note Added",
                                                  note.text,
                                                  widget.appointment
                                                      .appointmentId,
                                                  widget.appointment.patientId,
                                                );

                                                if (res == 200 || res == 201) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: ShowCustomSnackBar(
                                                      title:
                                                          "Note Added Successfully",
                                                      label: '',
                                                      color: Colors.green,
                                                      icon: Icons.done_outlined,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: ShowCustomSnackBar(
                                                      title:
                                                          "Something Went Wrong",
                                                      label:
                                                          'Please Try Again Later',
                                                      color: Colors.red,
                                                      icon:
                                                          Icons.warning_rounded,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));
                                                }
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              child: const Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 20,
                                width: 80,
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

                            const SizedBox(height: 10),

                            // Medication
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return const AddMedicationDialog();
                                    return Dialog(
                                      child: Container(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Add Medication',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  labelText: 'Medication Name'),
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  labelText: 'Dosage'),
                                            ),
                                            TextFormField(
                                              decoration: const InputDecoration(
                                                  labelText: 'Frequency'),
                                            ),
                                            const SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Medication newMedication =
                                                    Medication(
                                                  name: 'Medication Name',
                                                  dosage: 'Dosage',
                                                  frequency: 'Frequency',
                                                  issuedOn: DateTime.now(),
                                                );

                                                List<Medication>
                                                    medicationList = [
                                                  newMedication
                                                ];

                                                int statusCode =
                                                    await addMedication(
                                                        widget.appointment
                                                            .patientId,
                                                        medicationList);

                                                if (statusCode == 200 ||
                                                    statusCode == 201) {
                                                  log("Medication added successfully.");

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: ShowCustomSnackBar(
                                                      title:
                                                          "Medications Added Successfully",
                                                      label: '',
                                                      color: Colors.green,
                                                      icon: Icons.done_outlined,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));

                                                  Navigator.of(context).pop();
                                                } else {
                                                  log("Failed to add medication. Status code: $statusCode");

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: ShowCustomSnackBar(
                                                      title:
                                                          "Something Went Wrong",
                                                      label:
                                                          'Please Try Again Later',
                                                      color: Colors.red,
                                                      icon:
                                                          Icons.warning_rounded,
                                                    ),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ));

                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: CustomColors.customGrey,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Medication',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Reschedule
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
                                                    log(selectedDate
                                                        .toString());
                                                  });
                                                }
                                              },
                                              child: const Text("Select Date"),
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

                            const SizedBox(height: 10),

                            // Threshold
                            GestureDetector(
                              onTap: () async {
                                AnalyticsThresholds thresholds =
                                    AnalyticsThresholds();

                                late TextEditingController water =
                                    TextEditingController();
                                late TextEditingController steps =
                                    TextEditingController();
                                late TextEditingController sleep =
                                    TextEditingController();
                                late TextEditingController calories =
                                    TextEditingController();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Set Analytics Thresholds'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextFormField(
                                            controller: water,
                                            onChanged: (value) {
                                              thresholds.water =
                                                  int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                                labelText: 'Water '),
                                          ),
                                          TextFormField(
                                            controller: steps,
                                            onChanged: (value) {
                                              thresholds.steps =
                                                  int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                                labelText: 'Steps '),
                                          ),
                                          TextFormField(
                                            controller: sleep,
                                            onChanged: (value) {
                                              thresholds.sleep =
                                                  int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                              labelText: 'Sleep ',
                                            ),
                                          ),
                                          TextFormField(
                                            controller: calories,
                                            onChanged: (value) {
                                              thresholds.calories =
                                                  int.parse(value);
                                            },
                                            decoration: const InputDecoration(
                                              labelText: 'Calories ',
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
                                            // Save the thresholds or perform any other action
                                            int res = await addThreshold(
                                              widget.appointment.patientId,
                                              thresholds.water,
                                              thresholds.calories,
                                              thresholds.steps,
                                              thresholds.sleep,
                                            );

                                            if (res == 200 || res == 201) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: ShowCustomSnackBar(
                                                  title:
                                                      "Threshold Set Successfully",
                                                  label: '',
                                                  color: Colors.green,
                                                  icon: Icons.done_outlined,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: ShowCustomSnackBar(
                                                  title: "Something Went Wrong",
                                                  label:
                                                      'Please Try Again Later',
                                                  color: Colors.red,
                                                  icon: Icons.warning_rounded,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ));
                                            }

                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Save'),
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
                                    'Threshold',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
