import 'package:flutter/material.dart';
import 'package:medezz/api/patient/doctors/fetchdoctors.dart';
import 'package:medezz/constants/colors.dart';
import 'package:medezz/screens/patient/profile/profile_page.dart';

class HomeScreenPatient extends StatefulWidget {
  const HomeScreenPatient({super.key});

  @override
  State<HomeScreenPatient> createState() => _HomeScreenPatientState();
}

class _HomeScreenPatientState extends State<HomeScreenPatient> {
  List<Doctors> doctorList = [];

  Future<void> fetchDoctorsList() async {
    List<Doctors> doc = await fetchDoctors();
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
      body: doctorList.isEmpty
          ? const Center(child: Text('No Available Doctors'))
          : ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemCount: doctorList.length,
              itemBuilder: (context, index) {
                Doctors doc = doctorList[index];

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CustomColors.primaryColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IMAGE
                        const Icon(Icons.person, size: 60),
                        // Image(
                        //   image: AssetImage("assets/images/doctors/doc1.jpg"),
                        //   width: 70,
                        //   height: 70,
                        // ),

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
            ),
    );
  }
}
