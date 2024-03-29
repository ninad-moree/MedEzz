// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:medezz/api/fitness/model/daily_log_datapoint.dart';
import 'package:medezz/api/fitness/screens/fitness_controller.dart';
import 'package:medezz/screens/patient/add_daily_data/logic/send_data.dart';
import 'package:medezz/screens/patient/gamification/plant_screen.dart';

import '../../../../widgets/custom_snackbar.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  TextEditingController steps = TextEditingController(text: "0");
  TextEditingController caloriesBurnt = TextEditingController(text: "0");
  TextEditingController calorieIntake = TextEditingController(text: "0");
  TextEditingController waterIntake = TextEditingController(text: "0");
  TextEditingController weight = TextEditingController(text: "0");
  TextEditingController bloodSugarLevel = TextEditingController(text: "0");
  bool medicineTaken = false;

  final controller = FitnessController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    DailyLogDatapoint datapoint = await controller.getData() ??
        DailyLogDatapoint(
          date: DateTime.now(),
          stepsWalked: 0,
          caloriesBurned: 0,
          medicineTaken: false,
        );
    setState(() {
      steps.text = datapoint.stepsWalked.toString();
      caloriesBurnt.text = datapoint.caloriesBurned.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDataTile('Steps', steps),
          const Divider(),
          _buildDataTile('Calories Burnt', caloriesBurnt),
          const Divider(),
          _buildDataTile('Calorie Intake', calorieIntake),
          const Divider(),
          _buildDataTile('Water Intake', waterIntake),
          const Divider(),
          _buildDataTile('Weight', weight),
          const Divider(),
          _buildDataTile('Blood Sugar Level', bloodSugarLevel),
          const Divider(),
          ListTile(
            title: Text("Medication Taken"),
            trailing: Checkbox(
              value: medicineTaken,
              onChanged: (value) => setState(() => medicineTaken = value!),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              http.Response response = await sendDailyDatapoint(
                DailyLogDatapoint(
                  date: DateTime.now(),
                  stepsWalked: int.parse(steps.text),
                  caloriesBurned: double.parse(caloriesBurnt.text),
                  caloriesIntake: double.parse(calorieIntake.text),
                  waterIntake: double.parse(waterIntake.text),
                  weight: double.parse(weight.text),
                  sugarLevel: double.parse(bloodSugarLevel.text),
                  medicineTaken: medicineTaken,
                ),
              );
              if (response.statusCode == 200 || response.statusCode == 201) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: ShowCustomSnackBar(
                    title: "Data Logged",
                    label: 'Data Logged Successfully',
                    color: Colors.green,
                    icon: Icons.done_outlined,
                  ),
                  behavior: SnackBarBehavior.floating,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ));
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const PlantScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: ShowCustomSnackBar(
                      title: "Something Went Wrong",
                      label: 'Please try Again',
                      color: Colors.red,
                      icon: Icons.warning_rounded,
                    ),
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTile(String label, TextEditingController controller) {
    return ListTile(
      title: Text(label),
      trailing: SizedBox(
        width: 100.0,
        child: TextField(
          controller: controller,
        ),
      ),
    );
  }
}
