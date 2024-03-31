import 'package:flutter/material.dart';

import '../model/footsteps.dart';

class HealthCard extends StatelessWidget {
  final FootSteps footSteps;
  const HealthCard({super.key, required this.footSteps});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            footSteps.value.toStringAsFixed(2),
            style: const TextStyle(fontSize: 24),
          ),
          Text(footSteps.unit),
          Text(
            footSteps.dateFrom.toString(),
          ),
        ],
      ),
    );
  }
}
