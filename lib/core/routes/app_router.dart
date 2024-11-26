import 'package:chattest/featuers/register/ui/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../featuers/content/ui/users.dart';
import '../../featuers/home/ui/homescreen.dart';
import '../../featuers/login/ui/login_screen.dart';
import 'router_constant.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: FirebaseAuth.instance.currentUser != null
        ? RouterConstant.home
        : RouterConstant.login,
    routes: [
      GoRoute(
        path: RouterConstant.login,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: RouterConstant.register,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: RouterConstant.home,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: RouterConstant.content,
        builder: (context, state) {
          return SelectUserScreen();
        },
      ),
    ],
  );
}
