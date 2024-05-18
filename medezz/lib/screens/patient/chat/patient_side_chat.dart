import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../../../api/patient/doctors/fetchdoctors.dart';
import '../../../api/patient/profile/view_profile.dart';
import 'model/message.dart';
import 'widgets/message_bubble.dart';

class PatientSideChatPage extends StatefulWidget {
  const PatientSideChatPage({super.key, required this.doctor});
  final Doctors doctor;

  @override
  State<PatientSideChatPage> createState() => _PatientSideChatPageState();
}

class _PatientSideChatPageState extends State<PatientSideChatPage> {
  late IOWebSocketChannel channel;
  TextEditingController controller = TextEditingController();
  late PatientProfile patientProfile = PatientProfile(username: '', email: '', id: '');
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    loadProfile();
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadProfile() async {
    PatientProfile prof = await viewProfile();
    setState(() {
      patientProfile = prof;
    });
    await getPreviousMessages();
    setState(() {
      channel = IOWebSocketChannel.connect('ws://healthlink-backend.onrender.com/?sender=${patientProfile.id}&receiver=${widget.doctor.id}');
    });
    Future.delayed(const Duration(seconds: 2), () {
      log('init');
      log("Patient ID: ${patientProfile.id}");
      log("Doctor ID: ${widget.doctor.id}");
      channel.sink.add(
        jsonEncode({
          'type': 'init',
          'message': controller.text,
          'senderId': patientProfile.id,
          'receiverId': widget.doctor.id,
        }),
      );
      channel.stream.listen((message) {
        setState(() {
          messages.add(Message.fromJson(jsonDecode(message)));
        });
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  Future<void> getPreviousMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final http.Response response = await http.get(
      Uri.parse("https://healthlink-backend.onrender.com/chat/${widget.doctor.id}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      log("Get Previous Messages Success");
      log(jsonResponse.toString());
      List<Message> msg = [];
      jsonResponse['chats'].forEach((e) {
        msg.add(Message.fromJson(e));
      });
      setState(() {
        messages = msg;
      });
      log(messages.length.toString());
    } else {
      log("Get Previous Messages Failure");
      log(response.statusCode.toString());
      log(response.body);
    }
    Future.delayed(const Duration(seconds: 1), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      channel.sink.add(
        jsonEncode({
          'type': 'chat',
          'message': controller.text,
          'senderId': patientProfile.id,
          'receiverId': widget.doctor.id,
        }),
      );
      controller.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor.name),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index], me: patientProfile.id);
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
                    decoration: const InputDecoration(labelText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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
