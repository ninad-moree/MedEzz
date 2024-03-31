class DailyLogDatapoint {
  DateTime date;
  int stepsWalked;
  double caloriesBurned;
  double? caloriesIntake = 0;
  double? waterIntake = 0;
  double? weight = 0;
  double? sugarLevel = 0;
  bool medicineTaken;
  int? screenTime = 0;

  DailyLogDatapoint({
    required this.date,
    required this.stepsWalked,
    required this.caloriesBurned,
    required this.medicineTaken,
    this.caloriesIntake,
    this.waterIntake,
    this.weight,
    this.sugarLevel,
    this.screenTime,
  });

  factory DailyLogDatapoint.fromJson(Map<String, dynamic> json) {
    return DailyLogDatapoint(
      date: json['date'],
      stepsWalked: json['stepsWalked'],
      caloriesBurned: json['caloriesBurned'],
      caloriesIntake: json['caloriesIntake'],
      waterIntake: json['waterIntake'],
      weight: json['weight'],
      sugarLevel: json['sugarLevel'],
      medicineTaken: json['medicineTaken'],
      screenTime: json['screenTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'stepsWalked': stepsWalked,
      'caloriesBurned': caloriesBurned,
      'caloriesIntake': caloriesIntake,
      'waterIntake': waterIntake,
      'weight': weight,
      'sugarLevel': sugarLevel,
      'medicineTaken': medicineTaken,
      'screenTime': screenTime,
    };
  }
}
