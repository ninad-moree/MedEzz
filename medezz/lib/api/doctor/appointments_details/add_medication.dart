import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medezz/api/doctor/appointments_details/appointement_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<int> addMedication(String patientId, List<Medication> medication) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> requestBody = {'medications': medication};

  final http.Response response = await http.post(
    Uri.parse(
        "https://healthlink-backend.onrender.com/patient/$patientId/medication"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );
  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
