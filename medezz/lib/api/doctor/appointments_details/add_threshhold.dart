// ignore_for_file: prefer_collection_literals, unnecessary_new, unnecessary_this

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsThresholds {
  dynamic water;
  dynamic steps;
  dynamic sleep;
  dynamic calories;

  AnalyticsThresholds({
    this.water = 4,
    this.steps = 3000,
    this.sleep = 8,
    this.calories = 2000,
  });

  factory AnalyticsThresholds.fromJson(Map<String, dynamic> json) {
    return AnalyticsThresholds(
      water: json['water'] ?? 4,
      steps: json['steps'] ?? 3000,
      sleep: json['sleep'] ?? 8,
      calories: json['calories'] ?? 2000,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['water'] = this.water;
    data['steps'] = this.steps;
    data['sleep'] = this.sleep;
    data['calories'] = this.calories;
    return data;
  }
}

Future<int> addThreshold(String patientId, dynamic water, dynamic calories,
    dynamic steps, dynamic sleep) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Map<String, dynamic> requestBody = {
    'water': water,
    'calories': calories,
    'steps': steps,
    'sleep': sleep,
  };

  final http.Response response = await http.post(
    Uri.parse(
        "https://healthlink-backend.onrender.com/doctor/analytics_thresholds/$patientId"),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Add Threshold Details");
  }

  log(response.statusCode.toString());
  log(response.body);
  return response.statusCode;
}
