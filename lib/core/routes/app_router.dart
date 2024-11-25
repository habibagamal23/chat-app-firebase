import 'package:chattest/featuers/register/ui/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../featuers/login/ui/login_screen.dart';
import 'router_constant.dart';



class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouterConstant.register,
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
    ],
  );
}
