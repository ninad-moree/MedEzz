class DailyLogDatapoint {
  int steps;
  double caloriesBurnt;
  double? calorieIntake;
  double? waterIntake;
  double? weight;
  double? bloodSugarLevel;

  DailyLogDatapoint({
    required this.steps,
    required this.caloriesBurnt,
    this.calorieIntake,
    this.waterIntake,
    this.weight,
    this.bloodSugarLevel,
  });

  factory DailyLogDatapoint.fromJson(Map<String, dynamic> json) {
    return DailyLogDatapoint(
      steps: json['steps'],
      caloriesBurnt: json['caloriesBurnt'],
      calorieIntake: json['calorieIntake'],
      waterIntake: json['waterIntake'],
      weight: json['weight'],
      bloodSugarLevel: json['bloodSugarLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'caloriesBurnt': caloriesBurnt,
      'calorieIntake': calorieIntake,
      'waterIntake': waterIntake,
      'weight': weight,
      'bloodSugarLevel': bloodSugarLevel,
    };
  }
}
