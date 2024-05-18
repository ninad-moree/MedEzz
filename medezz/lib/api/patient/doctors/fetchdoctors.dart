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
