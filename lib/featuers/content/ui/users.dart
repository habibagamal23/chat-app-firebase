import 'package:chattest/featuers/content/model/user_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/contant_cubit.dart';
import 'package:intl/intl.dart';

class SelectUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text(
            "All Users",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body:
            BlocBuilder<ContantCubit, ContantState>(builder: (context, state) {
          if (state is UsersLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is UsersLoaded) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return CardSelectedUsers(
                    userProfile: user,
                  );
                });
          }

          if (state is UsersError) {
            return Center(child: Text("erro ${state.errormass}"));
          }
          return Center(child: Text("no users"));
        }));
  }
}

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
