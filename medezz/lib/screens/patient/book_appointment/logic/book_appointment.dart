import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> bookAppointment(
  String doctorId,
  DateTime time,
  int duration,
  bool isOnline,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  log(token ?? '...');

  Map<String, dynamic> requestBody = {
    'doctor': doctorId,
    'date': time.toIso8601String(),
    'duration': duration,
    'isOnline': isOnline,
  };

  final http.Response response = await http.post(
    Uri.parse("https://healthlink-backend.onrender.com/patient/appointment"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Doctor Registered Succesfully");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
