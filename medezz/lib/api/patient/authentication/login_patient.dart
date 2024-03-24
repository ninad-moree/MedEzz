import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginPatient(String email, String password) async {
  Map<String, dynamic> requestBody = {
    'email': email,
    'password': password,
  };

  final http.Response response = await http.post(
    Uri.parse("https://healthlink-backend.onrender.com/user/login"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  log(response.statusCode.toString());
  log(response.body);

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Patient Logged In Succesfully");
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    String accessToken = responseBody['accessToken'];
    return {'statusCode': response.statusCode, 'accessToken': accessToken};
  } else {
    return {'statusCode': response.statusCode};
  }
}
