import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../model/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final String me;
  const MessageBubble({required this.message, required this.me, super.key});

  @override
  Widget build(BuildContext context) {
    bool isSentByMe = message.sender == me;
    return BubbleSpecialOne(
      text: message.message,
      color: isSentByMe ? Colors.blue : Colors.green,
      textStyle: const TextStyle(color: Colors.white),
      isSender: isSentByMe,
    );
  }
}
