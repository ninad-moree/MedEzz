import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medezz/constants/colors.dart';

class NotificationForm extends StatefulWidget {
  const NotificationForm({super.key});

  @override
  State<NotificationForm> createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _medicineNameController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _selectedFrequencyIndex = 0;
  final List<String> _frequencyOptions = [
    'Once a week',
    'Twice a week',
    'Thrice a week'
  ];

  void _submitForm() {
    // Add your logic here for handling form submission
    String medicineName = _medicineNameController.text;
    String selectedTime = _selectedTime.format(context);
    String selectedFrequency = _frequencyOptions[_selectedFrequencyIndex];

    // Print or use the collected data as needed
    log('Medicine Name: $medicineName');
    log('Selected Time: $selectedTime');
    log('Selected Frequency: $selectedFrequency');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Form',
          style: TextStyle(color: CustomColors.primaryColor),
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
                child: DropdownButtonFormField<int>(
                  borderRadius: BorderRadius.zero,
                  value: _selectedFrequencyIndex,
                  items: List.generate(
                    _frequencyOptions.length,
                    (index) => DropdownMenuItem<int>(
                      value: index,
                      child: Text(_frequencyOptions[index]),
                    ),
                  ),
                  onChanged: (index) {
                    setState(() {
                      _selectedFrequencyIndex = index!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Frequency',
                  ),
                ),
              ),

              const SizedBox(height: 28.0),

              // Submit
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
