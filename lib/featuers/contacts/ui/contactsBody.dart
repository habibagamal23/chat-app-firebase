import 'package:chattest/featuers/contacts/ui/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/users_cubit.dart';

class ContactsBody extends StatelessWidget {
  const ContactsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
      if (state is UsersLoading) {
        return const CircularProgressIndicator();
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

      return const  Text("Intial ");
    });
  }
}
