import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<dynamic> signUpDoctor(
    String username, String email, String password) async {
  Map<String, dynamic> requestBody = {
    'username': username,
    'email': email,
    'password': password,
  };

  final http.Response response = await http.post(
    Uri.parse("https://healthlink-backend.onrender.com/doctor/register"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Doctor Registered Succesfully");
  }

  log(response.body);
  return response.statusCode;
}
