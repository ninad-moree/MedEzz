import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getAppointments() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('docToken');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/doctor/appointment"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Get Appointments Success");
    log(response.statusCode.toString());
    log(response.body);
  } else {
    log("Get Appointments Failure");
    log(response.statusCode.toString());
    log(response.body);
  }
}
