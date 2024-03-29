import 'package:flutter/material.dart';

import '../../../api/patient/doctors/fetchdoctors.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../model/doctor_category_model.dart';
import '../profile/profile_page.dart';
import 'widget/doctor_category.dart';

class HomeScreenPatient extends StatefulWidget {
  const HomeScreenPatient({super.key});

  @override
  State<HomeScreenPatient> createState() => _HomeScreenPatientState();
}

class _HomeScreenPatientState extends State<HomeScreenPatient> {
  List<Doctors> doctorList = [];
  Map<String, List<Doctors>> doctorsBySpecialization = {};

  List<Doctors> cardioList = [];
  List<Doctors> pediaList = [];
  List<Doctors> oncoList = [];
  List<Doctors> skinList = [];
  List<Doctors> kidneyList = [];
  List<Doctors> orthoList = [];

  Future<void> fetchDoctorsList() async {
    List<Doctors> doc = await fetchDoctors();

    for (var doctor in doc) {
      if (doctor.specialization == 'Cardiologist') {
        cardioList.add(doctor);
      }
      if (doctor.specialization == 'Pediatrician') {
        pediaList.add(doctor);
      }
      if (doctor.specialization == 'Oncologist') {
        oncoList.add(doctor);
      }
      if (doctor.specialization == 'Skin') {
        skinList.add(doctor);
      }
      if (doctor.specialization == 'Kidney') {
        kidneyList.add(doctor);
      }
      if (doctor.specialization == 'Orthopedic') {
        orthoList.add(doctor);
      }
    }

    setState(() {
      doctorList = doc;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDoctorsList();
  }

  @override
  Widget build(BuildContext context) {
    List<DoctorCategoryModel> docCat = [
      DoctorCategoryModel(
        doctorList: skinList,
        image: AssetImage(CustomImage.skin),
        title: "Skin",
      ),
      DoctorCategoryModel(
        image: AssetImage(CustomImage.cardio),
        title: "Cardio",
        doctorList: cardioList,
      ),
      DoctorCategoryModel(
        doctorList: kidneyList,
        image: AssetImage(CustomImage.kidney),
        title: "Kidney",
      ),
      DoctorCategoryModel(
        image: AssetImage(CustomImage.oncologist),
        title: "Oncologist",
        doctorList: oncoList,
      ),
      DoctorCategoryModel(
        doctorList: pediaList,
        image: AssetImage(CustomImage.pediatrician),
        title: "Pediatrician",
      ),
      DoctorCategoryModel(
        image: AssetImage(CustomImage.orthopedic),
        title: "Orthodpedic",
        doctorList: orthoList,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenPatient(),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
        title: const Text(
          'Doctors',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: docCat
            .map((catData) => DoctorCategoryItem(doctorCat: catData))
            .toList(),
      ),
      // body: doctorList.isEmpty
      //     ? const Center(child: Text('No Available Doctors'))
      //     : DoctorListView(doctorList: doctorList),
    );
  }
}
