import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medezz/constants/colors.dart';
import 'package:medezz/screens/patient/notifications/Services/notification_services.dart';

import '../../../widgets/custom_snackbar.dart';

class NotificationForm extends StatefulWidget {
  const NotificationForm({super.key});

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _medicineNameController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final NotificationService _notificationService = NotificationService();
  final List<String> _frequencyOptions = ['M', 'Tu', 'W', 'Th', 'F', 'Sa', 'Su'];

  final Set<int> _selectedDays = {};

  void _submitForm() {
    _formKey.currentState!.validate();
    String medicineName = _medicineNameController.text;
    DateTime selectedTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    List<String> selectedDays = _selectedDays.map((index) => _frequencyOptions[index]).toList();

    _notificationService.showDelayedNotification(
      schedule: selectedTime,
      medicationName: medicineName,
    );

    log('Medicine Name: $medicineName');
    log('Selected Time: $selectedTime');
    log('Selected Days: $selectedDays');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ShowCustomSnackBar(
        title: "Reminder Added",
        label: '$medicineName reminder added.',
        color: Colors.green,
        icon: Icons.done_outlined,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ));

    _medicineNameController.clear();
    _selectedTime = TimeOfDay.now();
    _selectedDays.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Medicine Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Medicine Field
              TextFormField(
                controller: _medicineNameController,
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // Time Picker
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: const Text('Select Time'),
                  subtitle: Text(
                    'Selected Time: ${_selectedTime.format(context)}',
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (pickedTime != null && pickedTime != _selectedTime) {
                      setState(() {
                        _selectedTime = pickedTime;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 16.0),

              // Frequency
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List<Widget>.generate(
                    _frequencyOptions.length,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedDays.contains(index)) {
                            _selectedDays.remove(index);
                          } else {
                            _selectedDays.add(index);
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: _selectedDays.contains(index)
                              ? CustomColors.primaryColor
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            _frequencyOptions[index],
                            style: TextStyle(
                              // color: Colors.white,
                              color: _selectedDays.contains(index)
                                  ? Colors.white
                                  : CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28.0),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(7, 82, 96, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
