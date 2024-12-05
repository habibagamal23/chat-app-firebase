import 'dart:io';

import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/core/wigdtes/customDate.dart';
import 'package:chattest/featuers/chat/logic/chat_cubit.dart';
import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/message_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel userProfile;

  const ChatScreen({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfile.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(userProfile.about)
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              if (state is ChatLoading) {
                return CircularProgressIndicator();
              }

              if (state is ChatSucces) {
                return ListView.builder(
                  reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      bool isme = state.messages[index].fromId ==
                          FirebaseStoreService().myUid;
                      return Align(
                        alignment:
                            isme ? Alignment.centerRight : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: isme ? Colors.blue : Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft:
                                  isme ? Radius.circular(16) : Radius.zero,
                             bottomRight :
                                  isme ? Radius.zero : Radius.circular(16),
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(state.messages[index].msg),
                                  Text(state.messages[index].createdAt)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (state is ChatError) {
                return Text(state.err);
              }
              return Text("No messages");
            }),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: context.read<ChatCubit>().messageContoller,
                  decoration: InputDecoration(label: Text("Message")),
                ),
              ),
              IconButton(
                  onPressed: () {
                    final msgco =
                        context.read<ChatCubit>().messageContoller.text;
                    if (msgco.isNotEmpty) {
                      context.read<ChatCubit>().sendMessgae(userProfile.id);
                      context.read<ChatCubit>().messageContoller.clear();
                    }
                  },
                  icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
