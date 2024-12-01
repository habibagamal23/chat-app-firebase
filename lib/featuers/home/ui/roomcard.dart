import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:flutter/material.dart';

import '../model/room.dart';

class UserCard extends StatelessWidget {
  final UserModel userProfile;
  final Room room;

  UserCard({required this.userProfile, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {

        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Text(
                            userProfile.name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        if (userProfile.online)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _buildUserDetails(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            ])));
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userProfile.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        room?.lastMessage != ''
            ? Text(
                room!.lastMessage,
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis),
              )
            : Text(
                userProfile.about,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ],
    );
  }
}
