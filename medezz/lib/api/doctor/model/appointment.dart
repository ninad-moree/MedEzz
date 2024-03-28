class Appointment {
  String appointmentId;
  DateTime date;
  String patientId;
  String patientName;
  String patientEmail;
  String patientContact;

  Appointment({
    required this.appointmentId,
    required this.date,
    required this.patientId,
    required this.patientName,
    required this.patientEmail,
    required this.patientContact,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      date: DateTime.parse(json['date']),
      patientId: json['patientId'],
      patientName: json['patientName'],
      patientEmail: json['patientEmail'],
      patientContact: json['patientContact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appointmentId': appointmentId,
      'date': date.toIso8601String(),
      'patientId': patientId,
      'patientName': patientName,
      'patientEmail': patientEmail,
      'patientContact': patientContact,
    };
  }
}
