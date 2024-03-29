import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PatientProfile {
  final String username;
  final String email;
  final String id;

  PatientProfile({
    required this.username,
    required this.email,
    required this.id,
  });

  factory PatientProfile.fromJson(Map<String, dynamic> json) {
    return PatientProfile(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

Future<dynamic> viewPatientProfile() async {
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

    // final Map<String, dynamic> jsonResponse = json.decode(response.body);
    // return PatientProfile.fromJson(jsonResponse);
  } else {
    log("View Patient Profile Failure");
    log(response.statusCode.toString());
    log(response.body);
    // return PatientProfile(username: '', email: '', id: '');
  }
}
