import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  final double caloriesBurnt;
  final double? calorieIntake;
  final double? waterIntake;
  final double? weight;
  final double? bloodSugarLevel;

  const DataPage({
    Key? key,
    required this.caloriesBurnt,
    this.calorieIntake,
    this.waterIntake,
    this.weight,
    this.bloodSugarLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDataTile('Calories Burnt', caloriesBurnt),
          const Divider(),
          _buildDataTile('Calorie Intake', calorieIntake),
          const Divider(),
          _buildDataTile('Water Intake', waterIntake),
          const Divider(),
          _buildDataTile('Weight', weight),
          const Divider(),
          _buildDataTile('Blood Sugar Level', bloodSugarLevel),
        ],
      ),
    );
  }

  Widget _buildDataTile(String label, double? value) {
    return ListTile(
      title: Text(label),
      trailing: Text(value?.toStringAsFixed(2) ?? 'N/A'), // Display value or 'N/A' if null
    );
  }
}
