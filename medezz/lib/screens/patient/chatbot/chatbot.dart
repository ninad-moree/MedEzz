import 'package:flutter/material.dart';
import 'package:medezz/constants/api_constants.dart';
import 'package:medezz/screens/patient/chatbot/widget/chat_widget.dart';

import '../../../constants/colors.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Chatbot',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ChatbotWidget(geminiAPI: ApiConstants.geminiAPI),
    );
  }
}
