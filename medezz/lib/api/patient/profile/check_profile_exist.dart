import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkProfileExist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/patient/check"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Check Profile Success");
    log(response.statusCode.toString());
    log(response.body);

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    bool existsValue = jsonResponse['exists'];
    return existsValue;
  } else {
    log("Check Profile Failure");
    log(response.statusCode.toString());
    log(response.body);
    return true;
  }
}


/* 
  {"exists":true}
*/