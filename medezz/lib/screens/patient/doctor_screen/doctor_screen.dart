import 'package:flutter/material.dart';
import 'package:medezz/api/patient/doctors/fetchdoctors.dart';
import 'package:medezz/screens/patient/home/home.dart';

import '../../../constants/colors.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen(
      {super.key, required this.doctorList, required this.title});

  final List<Doctors> doctorList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: DoctorListView(doctorList: doctorList),
    );
  }
}
