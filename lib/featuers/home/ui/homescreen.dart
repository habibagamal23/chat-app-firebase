import 'package:chattest/core/firebase_service/firebase_Auth.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/core/routes/router_constant.dart';
import 'package:chattest/featuers/contacts/logic/users_cubit.dart';
import 'package:chattest/featuers/home/logic/rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'HomeBody.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomsCubit(FirebaseStoreService())..fetchAllData(),
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    await FirebaseAuthService().logout();
                    context.go(RouterConstant.register);
                  },
                  icon: const Icon(Icons.logout))
            ],
            title: Text('Home', style: TextStyle(fontSize: 20.sp)),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<UsersCubit>().showAllusers();
              context.push(RouterConstant.content);
            },
            child: const Icon(Icons.add),
          ),
          body: const HomeBody()),
    );
  }
}
