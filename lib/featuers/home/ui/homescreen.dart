import 'package:chattest/core/firebase_service/firebase_Auth.dart';
import 'package:chattest/core/routes/app_router.dart';
import 'package:chattest/core/routes/router_constant.dart';
import 'package:chattest/featuers/content/logic/contant_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ContantCubit>().fetchAlluserWithoutme();
          context.push(RouterConstant.content);
        },
      ),
    );
  }
}
