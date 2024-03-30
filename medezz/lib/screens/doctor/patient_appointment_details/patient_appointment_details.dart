import 'package:flutter/material.dart';
import 'package:medezz/api/doctor/appointments_details/appointement_details.dart';
import 'package:medezz/screens/doctor/chat/screens/doctor_side_chat.dart';

import '../../../api/doctor/profile/doctor_profile.dart';
import '../../../constants/colors.dart';

class PatientAppointmentDetails extends StatefulWidget {
  const PatientAppointmentDetails({super.key, required this.patientId});

  final String patientId;

  @override
  State<PatientAppointmentDetails> createState() =>
      _PatientAppointmentDetailsState();
}

class _PatientAppointmentDetailsState extends State<PatientAppointmentDetails> {
  List<Appointment1> appointments = [
    Appointment1(
      date: DateTime.now(),
      doctor: '',
      notes: '',
    ),
  ];

  List<Medication> medications = [
    Medication(name: '', dosage: '', frequency: '', issuedOn: DateTime.now()),
  ];

  List<Reminder> remainders = [
    Reminder(
      medicine: '',
      timing: [''],
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      declinedOn: [DateTime.now()],
    )
  ];

  List<TestResult> testResult = [
    TestResult(testName: '', testDate: DateTime.now(), testResult: ''),
  ];

  List<AnalyticsData> analData = [
    AnalyticsData(
      date: DateTime.now(),
      heartRate: 0,
      bloodPressure: '',
      weight: 0.0,
      sugarLevel: 0.0,
      temperature: 0.0,
      oxygenLevel: 0.0,
      stepsWalked: 0,
      caloriesBurned: 0,
      sleepDuration: 0,
      waterIntake: 0,
      caloriesIntake: 0,
      callTime: 0,
      videoCallTime: 0,
      screenTime: 0,
      messageCount: 0,
      medicineTaken: false,
      medicineMissed: 0,
    ),
  ];

  late Patient patientDetails = Patient(
    id: '',
    firstName: '',
    lastName: '',
    age: 0,
    gender: 'Male',
    contactNumber: '',
    email: '',
    address: Address(
      street: '',
      city: '',
      state: '',
      zipCode: '',
    ),
    healthConditions: [],
    medications: medications,
    appointments: appointments,
    reminders: remainders,
    user: '',
    testResults: testResult,
    analytics: analData,
    streaks: {},
    maxStreaks: {},
    analyticsThresholds: {},
  );

  late DoctorProfile profile = DoctorProfile(username: '', email: '', id: '');

  @override
  void initState() {
    super.initState();
    loadProfile();
    loadPatientDetailsProfile();
  }

  Future<void> loadPatientDetailsProfile() async {
    Patient pat = await viewPatientProfileDoctor(widget.patientId);
    setState(() {
      patientDetails = pat;
    });
  }

  Future<void> loadProfile() async {
    DoctorProfile prof = await viewDoctorProfile();
    setState(() {
      profile = prof;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Patient Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Information'),
            _buildBasicInfo(),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            _buildSectionTitle('Health Conditions'),
            _buildHealthConditions(),
            const SizedBox(height: 20),
            _buildSectionTitle('Medications'),
            _buildMedications(),
            const SizedBox(height: 20),
            _buildSectionTitle('Appointments'),
            _buildAppointments(),
            const SizedBox(height: 20),
            _buildSectionTitle('Reminders'),
            _buildReminders(),
            const SizedBox(height: 20),
            _buildSectionTitle('Test Results'),
            _buildTestResults(),
            const SizedBox(height: 20),
            _buildSectionTitle('Analytics Data'),
            _buildAnalyticsData(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorSideChatPage(
                  patient: patientDetails, doctorId: profile.id),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: CustomColors.primaryColor,
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${patientDetails.firstName} ${patientDetails.lastName}',
            ),
            const SizedBox(height: 10),
            Text('Age: ${patientDetails.age}'),
            const SizedBox(height: 10),
            Text('Gender: ${patientDetails.gender}'),
            const SizedBox(height: 10),
            Text('Contact Number: ${patientDetails.contactNumber}'),
            const SizedBox(height: 10),
            Text('Email: ${patientDetails.email}'),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthConditions() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: patientDetails.healthConditions.map((condition) {
            return Text('- $condition');
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMedications() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: patientDetails.medications.map((medication) {
            return ListTile(
              title: Text('${medication.name} (${medication.dosage})'),
              subtitle: Text(
                'Frequency: ${medication.frequency}\nIssued on: ${medication.issuedOn}',
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAppointments() {
    List<Appointment1> filteredAppointments = patientDetails.appointments
        .where((appointment) => appointment.doctor == profile.id)
        .toList();

    return Card(
      elevation: 2,
      child: Column(
        children: filteredAppointments.map((appointment) {
          bool isPastAppointment = appointment.date.isBefore(DateTime.now());
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isPastAppointment
                      ? const Text("Prev")
                      : const Text("Upcoming"),
                  Text("Doctor: ${profile.username}"),
                  Text("Date: ${appointment.date}"),
                  appointment.notes == ""
                      ? const Text("No Previous Notes")
                      : Text("Notes: ${appointment.notes}"),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReminders() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: patientDetails.reminders.map((reminder) {
            return ListTile(
              title: Text('Medicine: ${reminder.medicine}'),
              subtitle: Text(
                'Timing: ${reminder.timing.join(", ")}\nStart Date: ${reminder.startDate}\nEnd Date: ${reminder.endDate}',
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTestResults() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: patientDetails.testResults.map((result) {
            return ListTile(
              title: Text('Test Name: ${result.testName}'),
              subtitle: Text(
                'Test Date: ${result.testDate}\nTest Result: ${result.testResult}',
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAnalyticsData() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: patientDetails.analytics.map((data) {
            return ListTile(
              title: Text('Date: ${data.date}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Heart Rate: ${data.heartRate}'),
                  Text('Blood Pressure: ${data.bloodPressure}'),
                  Text('Weight: ${data.weight}'),
                  Text('Sugar Level: ${data.sugarLevel}'),
                  Text('Temperature: ${data.temperature}'),
                  Text('Oxygen Level: ${data.oxygenLevel}'),
                  Text('Steps Walked: ${data.stepsWalked}'),
                  Text('Calories Burned: ${data.caloriesBurned}'),
                  Text('Sleep Duration: ${data.sleepDuration}'),
                  Text('Water Intake: ${data.waterIntake}'),
                  Text('Calories Intake: ${data.caloriesIntake}'),
                  Text('Call Time: ${data.callTime}'),
                  Text('Video Call Time: ${data.videoCallTime}'),
                  Text('Screen Time: ${data.screenTime}'),
                  Text('Message Count: ${data.messageCount}'),
                  Text('Medicine Taken: ${data.medicineTaken}'),
                  Text('Medicine Missed: ${data.medicineMissed}'),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
