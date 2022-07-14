import 'package:flutter/foundation.dart';

import '../models/practice_model.dart';

class Data with ChangeNotifier {

  final List<Questions>? _practiceQuestions = PracticeModel().questions;
  List<Questions>? get testQuestions {
    return _practiceQuestions;
  }

  final List<Messages> _messages = [
    Messages(isMe: true, message: 'Message sent by me'),
    Messages(isMe: false, message: 'Message sent by others'),
    Messages(isMe: true, message: 'Message sent by me'),
    Messages(isMe: false, message: 'Message sent by others'),
  ];
  List<Messages> get messages {
    return [..._messages];
  }
}


class Messages {
  final String message;
  final bool isMe;

  Messages({
    required this.isMe,
    required this.message,
  });
}
