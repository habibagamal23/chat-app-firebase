import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/firebase_service/firebase_store.dart';
import '../../model/message_model.dart';

class ChatMessageCard extends StatelessWidget {
  final Message messageItem;

  const ChatMessageCard({required this.messageItem});

  @override
  Widget build(BuildContext context) {
    final bool isMe = messageItem.fromId == FirebaseStoreService().myUid;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
              bottomRight: isMe ? Radius.zero : const Radius.circular(16),
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
            ),
          ),
          color: isMe ? Colors.blue : Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(messageItem.msg),
                const SizedBox(height: 5),
                Text(
                  DateFormat.jm().format(
                    DateTime.parse(messageItem.createdAt),
                  ),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
