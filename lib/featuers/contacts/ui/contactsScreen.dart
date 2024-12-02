import 'package:flutter/material.dart';
import 'contactsBody.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "All Users",
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: const ContactsBody());
  }
}
