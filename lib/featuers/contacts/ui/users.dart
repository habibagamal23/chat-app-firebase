import 'package:chattest/featuers/contacts/logic/users_cubit.dart';
import 'package:chattest/featuers/contacts/ui/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectUserScreen extends StatelessWidget {
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
        body: BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
          if (state is UsersLoading) {
            return CircularProgressIndicator();
          }
          if (state is UsersSuccuss) {
            return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return CardSelectedUsers(userProfile: state.users[index]);
                });
          }

          if (state is UsersErorr) {
            return Text(state.msg);
          }

          return Text("Intial ");
        }));
  }
}
