// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medezz/screens/patient/book_appointment/logic/book_appointment.dart';

import '../../../../widgets/custom_snackbar.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({required this.doctorId, super.key});
  final String doctorId;

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _durationInMinutes = 30;
  bool _isOnline = false;
  bool showDateTime = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        ) ??
        DateTime.now().add(const Duration(days: 1));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        showDateTime = true;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        ) ??
        TimeOfDay.now();
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        showDateTime = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Select Date:'),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(showDateTime
                      ? DateFormat('dd / MM / yyyy').format(_selectedDate)
                      : 'Select Date'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Select Time:'),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text(showDateTime
                      ? "${_selectedTime.hour} : ${_selectedTime.minute}"
                      : 'Select Time'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Duration (in minutes):'),
            DropdownButton<int>(
              value: _durationInMinutes,
              onChanged: (value) {
                setState(() {
                  _durationInMinutes = value ?? 0;
                });
              },
              items: [15, 30, 45, 60].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value minutes'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Appointment Type:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Online'),
                Switch(
                  value: _isOnline,
                  onChanged: (value) {
                    setState(() {
                      _isOnline = value;
                    });
                  },
                ),
                const Text('Offline'),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                _selectedDate = _selectedDate.add(Duration(
                    hours: _selectedTime.hour, minutes: _selectedTime.minute));
                log('Date: $_selectedDate');
                log('Duration: $_durationInMinutes minutes');
                log('Is Online: $_isOnline');
                int response = await bookAppointment(widget.doctorId,
                    _selectedDate, _durationInMinutes, _isOnline);
                if (response == 200 || response == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: ShowCustomSnackBar(
                        title: "Appointment Booked",
                        label: 'Go back to doctors.',
                        color: Colors.green,
                        icon: Icons.done_outlined,
                      ),
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: ShowCustomSnackBar(
                        title: "Couldn't Book Appointment",
                        label: "Something Went Wrong",
                        color: Colors.red,
                        icon: Icons.warning_rounded,
                      ),
                      behavior: SnackBarBehavior.floating,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
