import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Doctors {
  final String id;
  final String email;
  final String name;
  final String address;
  final String specialization;

  Doctors({
    required this.id,
    required this.email,
    required this.name,
    required this.address,
    required this.specialization,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      address: json['address'],
      specialization: json['specialization'],
    );
  }
}

Future<List<Doctors>> fetchDoctors() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/user/doctors"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Get Doctors Success");
    log(response.statusCode.toString());
    log(response.body);

    final List<dynamic> jsonResponse = json.decode(response.body);
    List<Doctors> doctorList =
        jsonResponse.map((json) => Doctors.fromJson(json)).toList();
    return doctorList;
  } else {
    log("Get Doctors Failure");
    log(response.statusCode.toString());
    log(response.body);
    return [];
  }
}


/* 
  [
    {
      "_id":"6603bcc322fe65278bab55dc",
      "email":"drsmith@example.com",
      "name":"Dr. John Smith",
      "address":"123 Main Street, City, Country",
      "specialization":"Cardiology"
    },
    {"_id":"6603bcea22fe65278bab55df","email":"drjane@example.com","name":"Dr. Jane Doe","address":"789 Elm Street, Townsville, Country","specialization":"Pediatrics"},
    {"_id":"6603e508b790617a48a0a697","email":"doctorjane@example.com","name":"Dr. Jane Doe","address":"456 Elm Street","specialization":"Family Medicine"},
    {"_id":"6603e614b790617a48a0a69a","email":"dr_rajan@example.com","name":"Dr. Rajan Sharma","address":"789 Maple Street, Cityville","specialization":"Pediatrics"},
    {"_id":"6603e686b790617a48a0a6a0","email":"dr_patel@example.com","name":"Dr. Neha Patel","address":"123 Oak Avenue, Townsville","specialization":"Internal Medicine"},
    {"_id":"6603e6ddb790617a48a0a6a6","email":"dr_sharma@example.com","name":"Dr. Priya Sharma","address":"456 Elm Street, Springfield","specialization":"Ophthalmology"},
    {"_id":"6603e6ebb790617a48a0a6a9","email":"dr_shar@example.com","name":"Dr. PriSharma","address":"456 Elm Stre, Springfield","specialization":"Ophthalmolo"},
    {"_id":"6603e6ffb790617a48a0a6b2","email":"dr_s@example.com","name":"Dr. PriSharma","address":"456 Elm Stre, Springfield","specialization":"Ophthalmolo"},
    {"_id":"6603e7f6ca4f1c4c471cf362","email":"dr_kumar@example.com","name":"Dr. Rahul Kumar","address":"123 Cedar Avenue, Hillside","specialization":"Cardiovascular Medicine"},
    {"_id":"6603e855ca4f1c4c471cf366","email":"dr_kum@example.com","name":"Dr. Rahul Kumar","address":"123 Cedar Avenue, Hillside","specialization":"Cardiovascular Medicine"}
  ]
*/