import 'dart:io';

import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/core/wigdtes/customDate.dart';
import 'package:chattest/featuers/chat/chat_cubit.dart';
import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'model/message_model.dart';

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
            Text(
              "Last Seen ${StylesDate.getLastActiveTime(userProfile.lastActivated)}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.accessibility_new_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(child:
                BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              if (state is MessagesLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MessagesSuccess) {
                return ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final meg = state.messages[index];
                      bool isme = meg.fromId == FirebaseStoreService().myUid;
                      return Align(
                        alignment:
                            isme ? Alignment.centerRight : Alignment.centerLeft,
                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  isme ? Radius.circular(16) : Radius.zero,
                              bottomRight:
                                  isme ? Radius.zero : Radius.circular(16),
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          color: isme ? Colors.blue : Colors.lightBlueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                Text(meg.msg),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(DateFormat.jm()
                                    .format(DateTime.parse(meg.createdAt))),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (state is MessagesError) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Center(
                child: Text("get start"),
              );
            })),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: context.read<ChatCubit>().messageController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {},
                              icon: const Icon(Icons.camera),
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        hintText: "Message",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final mes =
                        context.read<ChatCubit>().messageController.text;
                    if (mes.isNotEmpty) {
                      context.read<ChatCubit>().sendMessage(userProfile.id);
                    }
                    context.read<ChatCubit>().messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

