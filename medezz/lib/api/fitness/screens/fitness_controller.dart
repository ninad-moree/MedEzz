import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/footsteps.dart';
import '../repository/health_repository.dart';

class HomeController {
  final repository = HealthRepository();
  final steps = ValueNotifier(<FootSteps>[]);
  Future<void> getData() async {
    steps.value = await repository.getFootSteep();
    log("Step count:");
    log(steps.value.toString());
  }
}
