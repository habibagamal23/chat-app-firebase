import 'package:chattest/core/firebase_service/firebase_Auth.dart';
import 'package:chattest/core/routes/router_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
