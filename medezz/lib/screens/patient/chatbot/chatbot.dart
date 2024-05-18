import 'package:flutter/material.dart';

import '../../../constants/api_constants.dart';
import '../../../constants/colors.dart';
import 'widget/chat_widget.dart';

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
