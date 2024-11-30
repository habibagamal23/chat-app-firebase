import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/user_Model.dart';

class CardSelectedUsers extends StatelessWidget {
  final UserModel userProfile;

  const CardSelectedUsers({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final DateTime lastActivated = DateTime.parse(userProfile.lastActivated);
    final formattedTime = DateFormat.jm().format(lastActivated);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        title: Text(
          userProfile.name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          userProfile.phoneNumber,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: Text(
          formattedTime,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
