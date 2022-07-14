import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          // width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0),
              bottomLeft: isMe
                  ? const Radius.circular(15.0)
                  : const Radius.circular(0.0),
              bottomRight: isMe
                  ? const Radius.circular(0.0)
                  : const Radius.circular(15.0),
            ),
            color: isMe ? Color(0xffC4C4C4) : Color(0xffC4C4C4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                offset: const Offset(1, 1),
              )
            ],
          ),
        ),
      ],
    );
  }
}
