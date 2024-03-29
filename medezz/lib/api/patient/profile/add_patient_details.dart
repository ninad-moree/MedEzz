import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> addPatientDetails(
  String firstName,
  String lastName,
  String gender,
  int age,
  String number,
  String email,
  List<String> healthCondition,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> requestBody = {
    'firstName': firstName,
    'lastName': lastName,
    'age': age,
    'gender': gender,
    'contactNumber': number,
    'email': email,
    'healthConditions': healthCondition,
  };

  final http.Response response = await http.post(
    Uri.parse("https://healthlink-backend.onrender.com/patient"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Patient Registered Succesfully");
  }

  log(response.body);
  return response.statusCode;
}
