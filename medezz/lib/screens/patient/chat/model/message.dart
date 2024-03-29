class Message {
  final String message;
  final String sender;
  final String receiver;
  final String type;

  Message(
      {required this.message, required this.sender, required this.receiver, this.type = 'message'});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      sender: json['sender'],
      receiver: json['receiver'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'receiver': receiver,
    };
  }
}
