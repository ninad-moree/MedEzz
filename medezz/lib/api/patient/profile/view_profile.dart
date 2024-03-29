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

Future<PatientProfile> viewProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/user/current"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("View Profile Success");
    log(response.statusCode.toString());
    log(response.body);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    log("View Profile Success");
    log(jsonResponse.toString());
    return PatientProfile.fromJson(jsonResponse);
  } else {
    log("View Profile Failure");
    log(response.statusCode.toString());
    log(response.body);
    return PatientProfile(username: '', email: '', id: '');
  }
}

/*
  {
    "username":"ninadM",
    "email":"ninad18@gmail.com",
    "id":"66002b220d379f3ff1d6cfff"
  }
*/
