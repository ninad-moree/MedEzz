// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../api/doctor/appointments_details/appointement_details.dart';
import '../../../api/patient/profile/put_patient_details.dart';
import '../../../api/patient/profile/view_patient_profile.dart';
import '../../../api/patient/profile/view_profile.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_snackbar.dart';

class PatientFormPut extends StatefulWidget {
  const PatientFormPut({super.key});

  @override
  State<PatientFormPut> createState() => _PatientFormPutState();
}

class _PatientFormPutState extends State<PatientFormPut> {
  late PatientProfile profile = PatientProfile(username: '', email: '', id: '');

  List<Appointment1> appointments = [Appointment1(date: DateTime.now(), doctor: '', notes: '')];

  List<Medication> medications = [
    Medication(name: '', dosage: '', frequency: '', issuedOn: DateTime.now()),
  ];

  List<Reminder> remainders = [
    Reminder(
      medicine: '',
      timing: [''],
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      declinedOn: [DateTime.now()],
    )
  ];

  List<TestResult> testResult = [
    TestResult(testName: '', testDate: DateTime.now(), testResult: ''),
  ];

  List<AnalyticsData> analData = [
    AnalyticsData(
      date: DateTime.now(),
      heartRate: 0,
      bloodPressure: '',
      weight: 0.0,
      sugarLevel: 0.0,
      temperature: 0.0,
      oxygenLevel: 0.0,
      stepsWalked: 0,
      caloriesBurned: 0,
      sleepDuration: 0,
      waterIntake: 0,
      caloriesIntake: 0,
      callTime: 0,
      videoCallTime: 0,
      screenTime: 0,
      messageCount: 0,
      medicineTaken: false,
      medicineMissed: 0,
    ),
  ];

  late Patient patientDetails = Patient(
    id: '',
    firstName: '',
    lastName: '',
    age: 0,
    gender: 'Male',
    contactNumber: '',
    email: '',
    address: Address(street: '', city: '', state: '', zipCode: ''),
    healthConditions: [],
    medications: medications,
    appointments: appointments,
    reminders: remainders,
    user: '',
    testResults: testResult,
    analytics: analData,
    streaks: {},
    maxStreaks: {},
    analyticsThresholds: {},
    healthScore: 0,
    engagementScore: 0,
  );

  final _formKey = GlobalKey<FormState>();

  late int _age;
  late String _number;
  late List<String> _healthCondition = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
    loadPatientDetailsProfile();
  }

  Future<void> loadPatientDetailsProfile() async {
    Patient pat = await viewPatientProfile();
    setState(() {
      patientDetails = pat;
    });
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your health condition';
                  }
                  return null;
                },
                onSaved: (value) {
                  _healthCondition = value!.split(',').map((e) => e.trim()).toList();
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
                      log('Form submitted!');

                      log('Age: $_age');
                      log('Number: $_number');
                      log('Email: ${profile.email}');
                      log('Health Condition: $_healthCondition');

                      int res = await putPatientDetails(
                        patientDetails.id,
                        _age,
                        _number,
                        _healthCondition,
                      );

                      if (res == 200 || res == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
            ],
          ),
        ),
      ),
    );
  }
}
