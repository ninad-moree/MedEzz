import 'package:flutter/material.dart';

import '../../../api/patient/doctors/fetchdoctors.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../model/doctor_category_model.dart';
import '../doctor_profile/doctor_detail_page.dart';
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

    // List<Doctors>? cardiologists = doctorsBySpecialization['Cardiologist'];
    // List<Doctors>? pediatricians = doctorsBySpecialization['Pediatrician'];
    // List<Doctors>? oncologists = doctorsBySpecialization['Oncologist'];
    // List<Doctors>? skinSpecialists = doctorsBySpecialization['Skin'];
    // List<Doctors>? kidney = doctorsBySpecialization['Kidney'];
    // List<Doctors>? orthopedic = doctorsBySpecialization['Orthopedic'];

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

class DoctorListView extends StatelessWidget {
  const DoctorListView({
    super.key,
    required this.doctorList,
  });

  final List<Doctors> doctorList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
      itemCount: doctorList.length,
      itemBuilder: (context, index) {
        Doctors doc = doctorList[index];

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.primaryColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IMAGE
                // const Icon(Icons.person, size: 60),
                const Image(
                  image: AssetImage("assets/images/doctors/doc3.png"),
                  width: 100,
                  height: 70,
                ),

                // DOCTOR INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doc.name.trim()),
                      Text(doc.email.trim()),
                      Text(doc.specialization.trim()),
                      Text(
                        doc.address.trim(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // BUTTON
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Consulting Fee'),
                    const Text(
                      'Rs. 199',
                      style: TextStyle(color: CustomColors.customGrey),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorDetailPage(doctor: doc),
                          ),
                        );
                      },
                      child: Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          color: CustomColors.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: const Center(
                          child: Text(
                            'View Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
