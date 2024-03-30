import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> addNotes(
    String notes, String appointmentId, String patientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> requestBody = {
    'notes': notes,
    'appointmentId': appointmentId,
    'patientId': patientId,
  };

  final http.Response response = await http.post(
    Uri.parse(
        "https://healthlink-backend.onrender.com/doctor/appointment-notes"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Add Notes Details");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
