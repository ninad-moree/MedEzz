import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Patient {
  String id;
  String firstName;
  String lastName;
  int age;
  String gender;
  String contactNumber;
  String email;
  Address address;
  List<String> healthConditions;
  List<Medication> medications;
  List<Appointment> appointments;
  List<Reminder> reminders;
  String user;
  List<TestResult> testResults;
  List<AnalyticsData> analytics;
  Map<String, int> streaks;
  Map<String, int> maxStreaks;
  Map<String, int> analyticsThresholds;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.healthConditions,
    required this.medications,
    required this.appointments,
    required this.reminders,
    required this.user,
    required this.testResults,
    required this.analytics,
    required this.streaks,
    required this.maxStreaks,
    required this.analyticsThresholds,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'Male',
      contactNumber: json['contactNumber'] ?? '',
      email: json['email'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
      healthConditions: List<String>.from(json['healthConditions'] ?? []),
      medications: List<Medication>.from(
          json['medications']?.map((x) => Medication.fromJson(x)) ?? []),
      appointments: List<Appointment>.from(
          json['appointments']?.map((x) => Appointment.fromJson(x)) ?? []),
      reminders: List<Reminder>.from(
          json['reminder']?.map((x) => Reminder.fromJson(x)) ?? []),
      user: json['user'] ?? '',
      testResults: List<TestResult>.from(
          json['test_results']?.map((x) => TestResult.fromJson(x)) ?? []),
      analytics: List<AnalyticsData>.from(
          json['analytics']?.map((x) => AnalyticsData.fromJson(x)) ?? []),
      streaks: Map<String, int>.from(json['streaks'] ?? {}),
      maxStreaks: Map<String, int>.from(json['maxStreaks'] ?? {}),
      analyticsThresholds:
          Map<String, int>.from(json['analytics_thresholds'] ?? {}),
    );
  }
}

class Address {
  String street;
  String city;
  String state;
  String zipCode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }
}

class Medication {
  String name;
  String dosage;
  String frequency;
  DateTime issuedOn;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.issuedOn,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      issuedOn: json['issuedOn'] != null
          ? DateTime.parse(json['issuedOn'])
          : DateTime.now(),
    );
  }
}

class Appointment {
  DateTime date;
  String doctor;
  String notes;

  Appointment({
    required this.date,
    required this.doctor,
    required this.notes,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      doctor: json['doctor'] ?? '',
      notes: json['notes'] ?? '',
    );
  }
}

class Reminder {
  String medicine;
  List<String> timing;
  DateTime startDate;
  DateTime endDate;
  List<DateTime> declinedOn;

  Reminder({
    required this.medicine,
    required this.timing,
    required this.startDate,
    required this.endDate,
    required this.declinedOn,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      medicine: json['medicine'] ?? '',
      timing: List<String>.from(json['timing'] ?? []),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      declinedOn: List<DateTime>.from(
          json['declinedOn']?.map((x) => DateTime.parse(x)) ?? []),
    );
  }
}

class TestResult {
  String testName;
  DateTime testDate;
  String testResult;

  TestResult({
    required this.testName,
    required this.testDate,
    required this.testResult,
  });

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      testName: json['test_name'] ?? '',
      testDate: json['test_date'] != null
          ? DateTime.parse(json['test_date'])
          : DateTime.now(),
      testResult: json['test_result'] ?? '',
    );
  }
}

class AnalyticsData {
  DateTime date;
  int heartRate;
  String bloodPressure;
  double weight;
  double sugarLevel;
  double temperature;
  double oxygenLevel;
  int stepsWalked;
  int caloriesBurned;
  int sleepDuration;
  int waterIntake;
  int caloriesIntake;
  int callTime;
  int videoCallTime;
  int screenTime;
  int messageCount;
  bool medicineTaken;
  int medicineMissed;

  AnalyticsData({
    required this.date,
    required this.heartRate,
    required this.bloodPressure,
    required this.weight,
    required this.sugarLevel,
    required this.temperature,
    required this.oxygenLevel,
    required this.stepsWalked,
    required this.caloriesBurned,
    required this.sleepDuration,
    required this.waterIntake,
    required this.caloriesIntake,
    required this.callTime,
    required this.videoCallTime,
    required this.screenTime,
    required this.messageCount,
    required this.medicineTaken,
    required this.medicineMissed,
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) {
    return AnalyticsData(
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      heartRate: json['heartRate'] ?? 0,
      bloodPressure: json['bloodPressure'] ?? '',
      weight: json['weight']?.toDouble() ?? 0.0,
      sugarLevel: json['sugarLevel']?.toDouble() ?? 0.0,
      temperature: json['temperature']?.toDouble() ?? 0.0,
      oxygenLevel: json['oxygenLevel']?.toDouble() ?? 0.0,
      stepsWalked: json['stepsWalked'] ?? 0,
      caloriesBurned: json['caloriesBurned'] ?? 0,
      sleepDuration: json['sleepDuration'] ?? 0,
      waterIntake: json['waterIntake'] ?? 0,
      caloriesIntake: json['caloriesIntake'] ?? 0,
      callTime: json['callTime'] ?? 0,
      videoCallTime: json['videoCallTime'] ?? 0,
      screenTime: json['screenTime'] ?? 0,
      messageCount: json['messageCount'] ?? 0,
      medicineTaken: json['medicineTaken'] ?? false,
      medicineMissed: json['medicineMissed'] ?? 0,
    );
  }
}

Future<Patient> viewPatientProfileDoctor(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/patient/$id"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("View Patient Profile at Doctor Success");
    log(response.statusCode.toString());
    log(response.body);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Patient.fromJson(jsonResponse);
  } else {
    log("View Patient Profile at Doctor Failure");
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
  {
    "address":{"street":"123 Main St","city":"Anytown","state":"CA","zipCode":"12345"},
    "streaks":{"calories":0,"medicine":0,"sleep":0,"steps":0,"water":0},
    "maxStreaks":{"medicine":0,"water":0,"steps":0,"sleep":0,"calories":0},
    "_id":"6605a7febb476fd63921ac86",
    "firstName":"John","lastName":"Doe",
    "age": 21
    "gender":"Male",
    "contactNumber":"123-456-7890",
    "email":"johndoe1@example.com",
    "healthConditions":["Hypertension","Diabetes"],
    "medications":[
      {"name":"Medicine A","dosage":"10mg","frequency":"Twice daily","issuedOn":"2024-02-22T00:00:00.000Z","_id":"6605a7febb476fd63921ac87"},
      {"name":"Medicine B","dosage":"20mg","frequency":"Once daily","issuedOn":"2024-02-22T00:00:00.000Z","_id":"6605a7febb476fd63921ac88"}
    ],
    "appointments":[
      {"date":"2024-04-01T05:36:00.000Z","doctor":"6603bcea22fe65278bab55df","_id":"6605a807bb476fd63921ac8f"},
      {"date":"2024-03-30T17:15:00.000Z","doctor":"6603e7f6ca4f1c4c471cf362","_id":"6605acab09ea59656ba9febc"},
      {"date":"2024-03-29T09:30:00.000Z","doctor":"6603bcc322fe65278bab55dc","_id":"66063ceb67a1722602ec08c6"},
      {"date":"2024-03-30T13:09:00.000Z","doctor":"6603e614b790617a48a0a69a","_id":"660670275ffc7aa47fb2dd58"},
      {"date":"2024-03-31T02:18:00.000Z","doctor":"6603e614b790617a48a0a69a","_id":"660670315ffc7aa47fb2dd6c"},
      {"date":"2024-03-31T15:27:00.000Z","doctor":"6603e614b790617a48a0a69a","_id":"660670325ffc7aa47fb2dd77"},
      {"date":"2024-03-30T18:26:00.000Z","doctor":"6603e6ffb790617a48a0a6b2","_id":"6606ba91fe8c78acba4a5d69"}
    ],"reminder":[
      {"medicine":"Medicine A","timing":["Morning","Evening"],"startDate":"2024-02-22T00:00:00.000Z","endDate":"2024-03-22T00:00:00.000Z","declinedOn":[],"_id":"6605a7febb476fd63921ac89"}
    ],
    "user":"66002b220d379f3ff1d6cfff",
    "test_results":[],
    "__v":7,
    "analytics":[],
    "maxStraks":{"calories":0,"medicine":0,"sleep":0,"steps":0,"water":0}
  }
*/

/*
  {
    "streaks":{"medicine":0,"water":0,"steps":0,"sleep":0,"calories":0},
    "maxStreaks":{"medicine":0,"water":0,"steps":0,"sleep":0,"calories":0},
    "_id":"6606d201f2579f4bae3af43c",
    "firstName":"Peeyush",
    "lastName":"Kulgude",
    "age":20,
    "gender":"Male",
    "contactNumber":"8828073248",
    "email":"peeyush.kulgude777@gmail.com",
    "healthConditions":["Arthritis","Fever"],
    "user":"6606874d2f7ddafecaac80c0",
    "medications":[],
    "appointments":[
      {"date":"2024-03-30T20:07:00.000Z","doctor":"6603e7f6ca4f1c4c471cf362","_id":"6606d213f2579f4bae3af43f"}
    ],
    "reminder":[],
    "test_results":[],
    "analytics":[],
    "__v":1
  }
*/