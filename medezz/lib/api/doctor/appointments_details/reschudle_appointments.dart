import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> rescheduleAppointment(
    DateTime newdate, String appointmentId, String patientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> requestBody = {
    'date': newdate.toIso8601String(),
    'appointmentId': appointmentId,
    'patientId': patientId,
  };

  final http.Response response = await http.put(
    Uri.parse(
      "https://healthlink-backend.onrender.com/doctor/appointmentUpdate",
    ),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Reschedule Appointment");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
