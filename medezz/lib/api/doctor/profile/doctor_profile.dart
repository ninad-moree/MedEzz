import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorProfile {
  final String username;
  final String email;
  final String id;

  DoctorProfile({
    required this.username,
    required this.email,
    required this.id,
  });

  factory DoctorProfile.fromJson(Map<String, dynamic> json) {
    return DoctorProfile(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

Future<DoctorProfile> viewDoctorProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('docToken');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/doctor/current"),
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
    return DoctorProfile.fromJson(jsonResponse);
  } else {
    log("View Profile Failure");
    log(response.statusCode.toString());
    log(response.body);
    return DoctorProfile(username: '', email: '', id: '');
  }
}

/*
   {"username":"dr_kumar","email":"dr_kumar@example.com","id":"6603e7f6ca4f1c4c471cf362"}
*/