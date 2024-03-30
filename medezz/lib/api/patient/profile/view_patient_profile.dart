import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medezz/api/doctor/appointments_details/appointement_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Patient> viewPatientProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/patient/me"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("View Patient Profile Success");
    log(response.statusCode.toString());
    log(response.body);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Patient.fromJson(jsonResponse);
  } else {
    log("View Patient Profile Failure");
    log(response.statusCode.toString());
    log(response.body);

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

    List<DateTime> declined = [DateTime.now()];

    List<Reminder> remainders = [
      Reminder(
        medicine: '',
        timing: [''],
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        declinedOn: declined,
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

    return Patient(
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
  }
}


/*
  {"streaks":{"medicine":0,"water":0,"steps":0,"sleep":0,"calories":0},"maxStreaks":{"medicine":0,"water":0,"steps":0,"sleep":0,"calories":0},"analytics_thresholds":{"water":4,"steps":3000,"sleep":8,"calories":2000},"_id":"660756e7d9964c9f35f6f2b8","firstName":"Ninad123","lastName":"Morw123","age":21,"gender":"Male","contactNumber":"7841987199","email":"kageyama69183@gmail.com","healthConditions":["Fever","Cold"],"user":"66075609d9964c9f35f6f2a6","medications":[],"appointments":[],"reminder":[],"test_results":[],"analytics":[],"__v":0}
*/