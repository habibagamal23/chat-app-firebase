import 'package:chattest/featuers/chat/ui/chatscreen.dart';
import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:chattest/featuers/register/ui/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../featuers/contacts/ui/contactsScreen.dart';
import '../../featuers/home/ui/homescreen.dart';
import '../../featuers/login/ui/login_screen.dart';
import 'router_constant.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: FirebaseAuth.instance.currentUser !=null
        ? RouterConstant.home: RouterConstant.register,
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
          return ContactsScreen();
        },
      ),
      GoRoute(
        path: RouterConstant.chat,
        builder: (context, state) {
          final UserModel userModel = state.extra as UserModel;

          return ChatScreen(userProfile: userModel!);
        },
      ),
    ],
  );
}
