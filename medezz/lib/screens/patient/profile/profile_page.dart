// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medezz/api/patient/profile/check_profile_exist.dart';
import 'package:medezz/api/fitness/screens/fitness_page.dart';
import 'package:medezz/api/patient/profile/view_patient_profile.dart';
import 'package:medezz/api/patient/profile/view_profile.dart';
import 'package:medezz/screens/doctor_patient/doctor_patient.dart';
import 'package:medezz/services/zego_login_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/doctor/appointments_details/appointement_details.dart';
import '../../../constants/colors.dart';
import '../patient_form/paitent_form_put.dart';
import '../patient_form/patient_form.dart';
import 'widget/info_tile.dart';

class ProfileScreenPatient extends StatefulWidget {
  const ProfileScreenPatient({super.key});

  @override
  State<ProfileScreenPatient> createState() => _ProfileScreenPatientState();
}

class _ProfileScreenPatientState extends State<ProfileScreenPatient> {
  late PatientProfile profile = PatientProfile(username: '', email: '', id: '');

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

  void _removeToken() async {
    onUserLogout();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: const ClipOval(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 60,
                  child: Image(
                    image: AssetImage("assets/images/user2.jpg"),
                  ),
                ),
              ),
            ),
          ),
          InfoTile(
            tileName: "User name :",
            content: profile.username,
            icon: Icons.person,
          ),
          InfoTile(
            tileName: "Email :",
            content: profile.email,
            icon: Icons.email,
          ),
          GestureDetector(
            onTap: () async {
              bool res = await checkProfileExist();
              if (res == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientFormPut(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PatientFormScreen(),
                  ),
                );
              }
            },
            child: const InfoTile(
              tileName: "Profile Details :",
              content: "Enter Profile Details",
              icon: Icons.details,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            height: 60,
            width: double.infinity,
            color: Colors.grey,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "L O G O U T",
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () async {
                      _removeToken();
                      await GoogleSignIn().signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorPatient(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.logout,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FitnessPage(),
            ),
          );
        },
        child: const Icon(Icons.fitness_center),
      ),
    );
  }
}
