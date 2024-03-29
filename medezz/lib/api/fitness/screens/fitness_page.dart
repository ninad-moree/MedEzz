import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/health_card.dart';
import 'fitness_controller.dart';

class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});
  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  final controller = FitnessController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Data')),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => controller.getData(),
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.steps,
        builder: (context, value, child) {
          return GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1, mainAxisSpacing: 15, crossAxisSpacing: 15),
            children: [
              for (final footSteps in value) HealthCard(footSteps: footSteps),
            ],
          );
        },
      ),
    );
  }
}
