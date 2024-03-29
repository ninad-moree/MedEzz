import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medezz/api/fitness/model/daily_log_datapoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> sendDailyDatapoint(DailyLogDatapoint datapoint) async {
  Map<String, dynamic> requestBody = datapoint.toJson();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final http.Response response = await http.post(
    Uri.parse("https://healthlink-backend.onrender.com/patient/analytics"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  log(response.statusCode.toString());
  log(response.body);

  Map<String, dynamic> responseBody = jsonDecode(response.body);
  return response;
}
