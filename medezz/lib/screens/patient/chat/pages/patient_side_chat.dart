import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medezz/api/patient/doctors/fetchdoctors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../api/patient/profile/view_profile.dart';
import 'package:web_socket_channel/io.dart';
import '../model/message.dart';

class PatientSideChatPage extends StatefulWidget {
  const PatientSideChatPage({super.key, required this.doctor});
  final Doctors doctor;

  @override
  State<PatientSideChatPage> createState() => _PatientSideChatPageState();
}

class _PatientSideChatPageState extends State<PatientSideChatPage> {
  final channel = IOWebSocketChannel.connect('ws://healthlink-backend.onrender.com/');
  TextEditingController controller = TextEditingController();
  late PatientProfile patientProfile = PatientProfile(username: '', email: '', id: '');
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
    channel.stream.listen((message) {
      setState(() {
        messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Future<void> loadProfile() async {
    PatientProfile prof = await viewProfile();
    setState(() {
      patientProfile = prof;
    });
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      channel.sink.add({
        'message': controller.text,
        'sender': patientProfile.id,
        'receiver': widget.doctor.id,});
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Example'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
