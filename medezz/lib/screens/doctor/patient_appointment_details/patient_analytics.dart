import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../api/doctor/appointments_details/appointement_details.dart';
import '../../../constants/colors.dart';
import '../../patient/analytics/widget/chart_data.dart';
import '../../patient/analytics/widget/chart_data_2.dart';

class PatientAnalytics extends StatefulWidget {
  const PatientAnalytics({super.key, required this.patientDetails});

  final Patient patientDetails;

  @override
  State<PatientAnalytics> createState() => _PatientAnalyticsState();
}

class _PatientAnalyticsState extends State<PatientAnalytics> {
  List<ChartData> getCaloriesIntakeChartData() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].caloriesIntake.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getCaloriesBurntChartData() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].caloriesBurned.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getSetpCount() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].stepsWalked.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getWaterIntake() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].waterIntake.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getScreenTime() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].screenTime.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getCallTime() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].callTime.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData> getMessageCount() {
    List<ChartData> data = [];

    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      data.add(ChartData(
        x: i.toDouble(),
        y: widget.patientDetails.analytics[i].messageCount.toDouble(),
      ));
    }

    return data;
  }

  List<ChartData2> getBooleanChartData() {
    int positiveCount = 0;
    int negativeCount = 0;

    // Iterate over your data source and count positive and negative values
    for (int i = 0; i < widget.patientDetails.analytics.length; i++) {
      bool value = widget.patientDetails.analytics[i].medicineTaken;
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: Text(
          "${widget.patientDetails.firstName} ${widget.patientDetails.lastName}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(widget.patientDetails.healthScore < 3
                            ? Colors.red
                            : widget.patientDetails.healthScore < 6
                                ? Colors.yellow
                                : Colors.green),
                      ),
                      child: Text(
                        'Health Score: ${widget.patientDetails.healthScore.toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(widget.patientDetails.engagementScore < 3
                            ? Colors.red
                            : widget.patientDetails.engagementScore < 6
                                ? Colors.yellow
                                : Colors.green),
                      ),
                      child: Text(
                        'Engagement Score: ${widget.patientDetails.engagementScore.toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
              const Text(
                'Screen Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getScreenTime(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Calories Intake',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Call Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getCallTime(),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Calories Intake',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Message Count',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: const NumericAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    LineSeries<ChartData, double>(
                      dataSource: getMessageCount(),
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
    );
  }
}
