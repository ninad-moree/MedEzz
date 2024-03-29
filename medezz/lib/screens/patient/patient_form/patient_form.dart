// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medezz/api/patient/profile/add_patient_details.dart';

import '../../../api/patient/profile/view_profile.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_snackbar.dart';

class PatientFormScreen extends StatefulWidget {
  const PatientFormScreen({super.key});

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  late PatientProfile profile = PatientProfile(username: '', email: '', id: '');

  final _formKey = GlobalKey<FormState>();

  late String _firstName;
  late String _lastName;
  late String _gender;
  late int _age;
  late String _number;
  late List<String> _healthCondition = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    PatientProfile prof = await viewProfile();
    setState(() {
      profile = prof;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Patient Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "First Name",
                        prefixIcon: const Icon(Iconsax.user_edit),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _firstName = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      // decoration: const InputDecoration(labelText: 'Last Name'),
                      decoration: InputDecoration(
                        labelText: "Last Name",
                        prefixIcon: const Icon(Iconsax.user_edit),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _lastName = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Gender",
                  prefixIcon: const Icon(Iconsax.user_edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
                onSaved: (value) {
                  _gender = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Age",
                  prefixIcon: const Icon(Iconsax.user_edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                onSaved: (value) {
                  _age = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Number",
                  prefixIcon: const Icon(Iconsax.user_edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _number = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Health Condition ( ',' separated)",
                  prefixIcon: const Icon(Iconsax.user_edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                // decoration: const InputDecoration(
                //   labelText: "Health Condition ( ',' separated)",
                // ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your health condition';
                  }
                  return null;
                },
                onSaved: (value) {
                  _healthCondition =
                      value!.split(',').map((e) => e.trim()).toList();
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle form submission here
                      log('Form submitted!');
                      log('First Name: $_firstName');
                      log('Last Name: $_lastName');
                      log('Gender: $_gender');
                      log('Age: $_age');
                      log('Number: $_number');
                      log('Email: ${profile.email}');
                      log('Health Condition: $_healthCondition');

                      int res = await addPatientDetails(
                        _firstName,
                        _lastName,
                        _gender,
                        _age,
                        _number,
                        profile.email,
                        _healthCondition,
                      );

                      if (res == 200 || res == 201) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: ShowCustomSnackBar(
                            title: "Patient Details Added",
                            label: "",
                            color: Colors.green,
                            icon: Icons.done_outlined,
                          ),
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: ShowCustomSnackBar(
                            title: "Something Went Wrong",
                            label: "",
                            color: Colors.red,
                            icon: Icons.warning_rounded,
                          ),
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                        ));
                      }
                    }
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
              // ElevatedButton(
              //   onPressed: () async {
              //     if (_formKey.currentState!.validate()) {
              //       _formKey.currentState!.save();
              //       // Handle form submission here
              //       log('Form submitted!');
              //       log('First Name: $_firstName');
              //       log('Last Name: $_lastName');
              //       log('Gender: $_gender');
              //       log('Age: $_age');
              //       log('Number: $_number');
              //       log('Email: ${profile.email}');
              //       log('Health Condition: $_healthCondition');

              //       int res = await addPatientDetails(
              //         _firstName,
              //         _lastName,
              //         _gender,
              //         _age,
              //         _number,
              //         profile.email,
              //         _healthCondition,
              //       );

              //       if (res == 200 || res == 201) {
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           content: ShowCustomSnackBar(
              //             title: "Patient Details Added",
              //             label: "",
              //             color: Colors.green,
              //             icon: Icons.done_outlined,
              //           ),
              //           behavior: SnackBarBehavior.floating,
              //           elevation: 0,
              //           backgroundColor: Colors.transparent,
              //         ));
              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //           content: ShowCustomSnackBar(
              //             title: "Something Went Wrong",
              //             label: "",
              //             color: Colors.red,
              //             icon: Icons.warning_rounded,
              //           ),
              //           behavior: SnackBarBehavior.floating,
              //           elevation: 0,
              //           backgroundColor: Colors.transparent,
              //         ));
              //       }
              //     }
              //   },
              //   child: const Text('Submit'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
