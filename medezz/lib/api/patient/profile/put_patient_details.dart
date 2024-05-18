import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> putPatientDetails(String id, int age, String number, List<String> healthCondition) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> requestBody = {
    'age': age,
    'contactNumber': number,
    'healthConditions': healthCondition,
  };

  final http.Response response = await http.put(
    Uri.parse("https://healthlink-backend.onrender.com/patient/$id"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Put Patient Details");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
