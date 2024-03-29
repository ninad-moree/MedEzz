import 'package:flutter/material.dart';
import 'package:medezz/api/doctor/appointments_details/appointement_details.dart';

import '../../../constants/colors.dart';

class PatientAppointmentDetails extends StatefulWidget {
  const PatientAppointmentDetails({super.key, required this.patientId});

  final String patientId;

  @override
  State<PatientAppointmentDetails> createState() =>
      _PatientAppointmentDetailsState();
}

class _PatientAppointmentDetailsState extends State<PatientAppointmentDetails> {
  List<Appointment> appointments = [
    Appointment(
      date: DateTime.now(),
      doctor: '',
      notes: '',
    ),
  ];

  List<Medication> medications = [
    Medication(name: '', dosage: '', frequency: '', issuedOn: DateTime.now()),
  ];

  // List<DateTime> declined = [DateTime.now()];

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
      medicineTaken: 0,
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
    address: Address(
      street: '',
      city: '',
      state: '',
      zipCode: '',
    ),
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
  );

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    Patient pat = await viewPatientProfileDoctor(widget.patientId);
    setState(() {
      patientDetails = pat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Patient Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () async {
            await viewPatientProfileDoctor(widget.patientId);
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(patientDetails.firstName),
        ],
      ),
    );
  }
}
