import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../api/doctor/appointments_details/appointement_details.dart';
import '../../../api/patient/profile/view_patient_profile.dart';
import '../../../constants/colors.dart';
import 'widget/chart_data.dart';
import 'widget/chart_data_2.dart';
import 'widget/leaderboard_dialog_box.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<Appointment1> appointments = [
    Appointment1(date: DateTime.now(), doctor: '', notes: ''),
  ];

  List<Medication> medications = [Medication(name: '', dosage: '', frequency: '', issuedOn: DateTime.now())];

  List<Reminder> remainders = [
    Reminder(medicine: '', timing: [''], startDate: DateTime.now(), endDate: DateTime.now(), declinedOn: [DateTime.now()])
  ];

  List<TestResult> testResult = [TestResult(testName: '', testDate: DateTime.now(), testResult: '')];

  List<AnalyticsData> analData = [
    AnalyticsData(
      date: DateTime.now(),
      heartRate: 0,
      bloodPressure: '',
      weight: 0.0,
      sugarLevel: 0.0,
      temperature: 0.0,
      oxygenLevel: 0.0,
      stepsWalked: 0,
      caloriesBurned: 0,
      sleepDuration: 0,
      waterIntake: 0,
      caloriesIntake: 0,
      callTime: 0,
      videoCallTime: 0,
      screenTime: 0,
      messageCount: 0,
      medicineTaken: false,
      medicineMissed: 0,
    ),
  ];

  late Patient patientDetails = Patient(
    id: '',
    firstName: '',
    lastName: '',
    age: 0,
    gender: 'Male',
    contactNumber: '',
    email: '',
    address: Address(street: '', city: '', state: '', zipCode: ''),
    healthConditions: [],
    medications: medications,
    appointments: appointments,
    reminders: remainders,
    user: '',
    testResults: testResult,
    analytics: analData,
    streaks: {},
    maxStreaks: {},
    analyticsThresholds: {},
    healthScore: 0,
    engagementScore: 0,
  );

  @override
  void initState() {
    super.initState();
    loadPatientDetailsProfile();
  }

  Future<void> loadPatientDetailsProfile() async {
    Patient pat = await viewPatientProfile();
    setState(() {
      patientDetails = pat;
    });
  }

  List<ChartData> getCaloriesIntakeChartData() {
    List<ChartData> data = [];

    for (int i = 0; i < patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: patientDetails.analytics[i].caloriesIntake.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getCaloriesBurntChartData() {
    List<ChartData> data = [];

    for (int i = 0; i < patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: patientDetails.analytics[i].caloriesBurned.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getSetpCount() {
    List<ChartData> data = [];

    for (int i = 0; i < patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: patientDetails.analytics[i].stepsWalked.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getWaterIntake() {
    List<ChartData> data = [];

    for (int i = 0; i < patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: patientDetails.analytics[i].waterIntake.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData2> getBooleanChartData() {
    int positiveCount = 0;
    int negativeCount = 0;

    // Iterate over your data source and count positive and negative values
    for (int i = 0; i < patientDetails.analytics.length; i++) {
      bool value = patientDetails.analytics[i].medicineTaken;
      if (value) {
        positiveCount++;
      } else {
        negativeCount++;
      }
    }

    // Create data points for positive and negative counts
    List<ChartData2> data = [
      ChartData2(x: 'Positive', y: positiveCount),
      ChartData2(x: 'Negative', y: negativeCount),
    ];

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Analytics',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(patientDetails.healthScore < 3
                        ? Colors.red
                        : patientDetails.healthScore < 6
                            ? Colors.yellow
                            : Colors.green),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Health Score: ${patientDetails.healthScore.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Steps Walked',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getSetpCount(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Calories Intake',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Medicine Taken',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    BarSeries<ChartData2, String>(
                      dataSource: getBooleanChartData(),
                      xValueMapper: (ChartData2 data, _) => data.x,
                      yValueMapper: (ChartData2 data, _) => data.y.toDouble(),
                      dataLabelSettings: const DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Calories Intake Graph',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getCaloriesIntakeChartData(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Calories Intake',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Calories Burned Graph',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getCaloriesBurntChartData(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Calories Intake',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Water Intake',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getWaterIntake(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Calories Intake',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showLeaderBoard(context);
        },
        child: const Icon(Icons.leaderboard),
      ),
    );
  }
}
