import 'package:chattest/core/firebase_service/firebase_Auth.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/core/routes/router_constant.dart';
import 'package:chattest/featuers/contacts/logic/users_cubit.dart';
import 'package:chattest/featuers/home/logic/rooms_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomsCubit(FirebaseStoreService()).. getRooms(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuthService().logout();
                  context.go(RouterConstant.register);
                },
                icon: Icon(Icons.logout))
          ],
          title: Text('Home', style: TextStyle(fontSize: 20.sp)),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          context.read<UsersCubit>().showAllusers();
          context.push(RouterConstant.content);
        }),
        body: BlocBuilder<RoomsCubit, RoomsState>(builder: (context, state) {
          if (state is RoomsLoading) {
            return CircularProgressIndicator();
          }

          if (state is RoomsSuceess) {
            return ListView.builder(
                itemCount: state.rooms.length,
                itemBuilder: (context, index) {
                  return Text(state.rooms[index].id);
                });
          }

          if (state is RoomsFealier) {
            return Text(state.msg);
          }

          return Text("no rooms");
        }),
      ),
    );
  }

  Widget _buildNoUserFoundTile() {
    return const ListTile(
      leading: Icon(Icons.person),
      title: Text('No other user found'),
      subtitle: Text('Room contains only your ID'),
    );
  }
}
