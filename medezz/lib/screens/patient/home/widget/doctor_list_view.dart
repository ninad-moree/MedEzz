import 'package:flutter/material.dart';

import '../../../../api/patient/doctors/fetchdoctors.dart';
import '../../../../constants/colors.dart';
import '../../doctor_profile/doctor_detail_page.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView({
    super.key,
    required this.doctorList,
  });

  final List<Doctors> doctorList;

  @override
  Widget build(BuildContext context) {
    return doctorList.isEmpty
        ? const Center(child: Text('No Available Doctors'))
        : ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
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
                                  'View',
                                  textAlign: TextAlign.center,
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
