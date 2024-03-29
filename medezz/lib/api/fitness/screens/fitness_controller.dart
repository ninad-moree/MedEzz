import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:medezz/api/fitness/model/daily_log_datapoint.dart';

import '../model/footsteps.dart';
import '../repository/health_repository.dart';

class FitnessController {
  final repository = HealthRepository();
  final ValueNotifier<List<FootSteps>> steps = ValueNotifier(<FootSteps>[]);

  Future<DailyLogDatapoint?> getData() async {
    steps.value = await repository.getFootSteep();
    DateTime now = DateTime.now();

    List<HealthDataPoint> calorieData = await repository.health.getHealthDataFromTypes(
      now.subtract(
        Duration(hours: now.hour, minutes: now.minute, seconds: now.second),
      ),
      now,
      [
        HealthDataType.ACTIVE_ENERGY_BURNED,
      ],
    );

    int totalSteps = 0;
    if (steps.value.isNotEmpty) {
      steps.value.forEach((element) {
        totalSteps += element.value.toInt();
      });
    }

    double totalCalories = 0;
    if (calorieData.isNotEmpty) {
      calorieData.forEach((element) {
        totalCalories += double.parse(element.value.toString());
      });
    }

    return DailyLogDatapoint(
      date: DateTime.now(),
      stepsWalked: totalSteps,
      caloriesBurned: totalCalories,
      medicationTaken: false,
    );
  }
}
