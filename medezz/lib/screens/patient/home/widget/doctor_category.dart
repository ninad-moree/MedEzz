import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../model/doctor_category_model.dart';
import '../../doctor_screen/doctor_screen.dart';

class DoctorCategoryItem extends StatelessWidget {
  final DoctorCategoryModel doctorCat;

  const DoctorCategoryItem({super.key, required this.doctorCat});

  void selectCategory(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => DoctorListScreen(
          doctorList: doctorCat.doctorList,
          title: doctorCat.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: CustomColors.primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 186, 183, 183).withOpacity(0.7),
              const Color.fromARGB(255, 186, 183, 183),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Image(image: doctorCat.image, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(doctorCat.title, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
