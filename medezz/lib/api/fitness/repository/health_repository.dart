import 'package:health/health.dart';

import '../model/footsteps.dart';

class HealthRepository {
  final health = HealthFactory();
  Future<List<FootSteps>> getFootSteep() async {
    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);
    if (requested) {
      var now = DateTime.now();
      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(const Duration(days: 1)),
          DateTime.now(),
          [HealthDataType.STEPS]);
      return healthData.map((e) {
        var b = e;
        return FootSteps(
          double.parse(b.value.toString()),
          b.unitString,
          b.dateFrom,
          b.dateTo,
        );
      }).toList();
    }
    return [];
  }
}