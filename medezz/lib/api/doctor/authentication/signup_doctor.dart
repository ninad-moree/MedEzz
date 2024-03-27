import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<dynamic> signUpDoctor(
  String username,
  String email,
  String password,
  String address,
  String specialization,
  String name,
) async {
  Map<String, dynamic> requestBody = {
    'name': name,
    'username': username,
    'email': email,
    'password': password,
    'address': address,
    'specialization ': specialization,
  };

  final http.Response response = await http.post(
    Uri.parse("https://healthlink-backend.onrender.com/doctor/register"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Doctor Registered Succesfully");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
