import 'package:flutter/material.dart';

import '../api/patient/doctors/fetchdoctors.dart';

class DoctorCategoryModel {
  final List<Doctors> doctorList;
  final AssetImage image;
  final String title;

  DoctorCategoryModel({
    required this.doctorList,
    required this.image,
    required this.title,
  });
}
