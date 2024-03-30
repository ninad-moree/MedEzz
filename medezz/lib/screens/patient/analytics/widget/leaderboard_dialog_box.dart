// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:medezz/constants/colors.dart';

import '../../../../api/doctor/appointments_details/appointement_details.dart';

showLeaderBoard(BuildContext context) async {
  List<Patient> patients = await getSortedPatients();
  patients = patients.sublist(0, 3);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Leaderboard',
          style: TextStyle(color: CustomColors.primaryColor),
        ),
        content: SizedBox(
          height: 200,
          width: 300,
          child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: index == 0
                    ? const Icon(FontAwesomeIcons.medal, color: Colors.amber, size: 20)
                    : index == 1
                        ? const Icon(FontAwesomeIcons.medal, color: Colors.grey, size: 20)
                        : index == 2
                            ? const Icon(FontAwesomeIcons.medal, color: Colors.brown, size: 20)
                            : const SizedBox(
                                height: 20,
                                width: 20,
                              ),
                title: Text("${patients[index].firstName} ${patients[index].lastName}"),
                subtitle: Text(patients[index].healthScore.toStringAsFixed(2)),
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

Future<List<Patient>> getSortedPatients() async {
  List<Patient> patients = await getPatients();
  patients.sort((a, b) => b.healthScore.compareTo(a.healthScore));
  return patients;
}

Future<List<Patient>> getPatients() async {
  List<Patient> patients = [];

  final http.Response response = await http.get(
    Uri.parse("https://healthlink-backend.onrender.com/patient"),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Get Patients Success");
    log(response.statusCode.toString());
    List data = jsonDecode(response.body);
    for (var patient in data) {
      patients.add(Patient.fromJson(patient));
    }
  } else {
    log("Get Patients Failure");
    log(response.statusCode.toString());
  }

  return patients;
}
