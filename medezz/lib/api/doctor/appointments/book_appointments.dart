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
  String? docToken = prefs.getString('docToken');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/doctor/appointment"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $docToken',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Doctor Registered Succesfully");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
