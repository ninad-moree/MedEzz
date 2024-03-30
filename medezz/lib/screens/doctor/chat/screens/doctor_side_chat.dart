import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medezz/api/doctor/appointments_details/appointement_details.dart';
import 'package:medezz/screens/patient/chat/model/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../../../patient/chat/widgets/message_bubble.dart';

class DoctorSideChatPage extends StatefulWidget {
  const DoctorSideChatPage({super.key, required this.patient, required this.doctorId});
  final Patient patient;
  final String doctorId;

  @override
  State<DoctorSideChatPage> createState() => _DoctorSideChatPageState();
}

class _DoctorSideChatPageState extends State<DoctorSideChatPage> {
  late IOWebSocketChannel channel;
  TextEditingController controller = TextEditingController();
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
    await getPreviousMessages();
    setState(() {
      channel = IOWebSocketChannel.connect(
          'ws://healthlink-backend.onrender.com/?sender=${widget.doctorId}&receiver=${widget.patient.user}');
    });
    Future.delayed(const Duration(seconds: 2), () {
      log('init');
      log("Patient ID: ${widget.patient.user}");
      log("Doctor ID: ${widget.doctorId}");
      channel.sink.add(
        jsonEncode({
          'type': 'init',
          'message': controller.text,
          'senderId': widget.doctorId,
          'receiverId': widget.patient.user,
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
    String? docToken = prefs.getString('docToken');

    final http.Response response = await http.get(
      Uri.parse("https://healthlink-backend.onrender.com/chat/${widget.patient.user}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $docToken',
      },
    );

    log("------------User------------");
    log(widget.patient.user);

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
          'senderId': widget.doctorId,
          'receiverId': widget.patient.user,
        }),
      );
      controller.clear();
      controller.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.patient.firstName} ${widget.patient.lastName}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index], me: widget.doctorId);
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
                  onPressed: () => sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
