import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/core/sharedprefrance/shared_pref_helper.dart';
import 'package:chattest/featuers/chat/chat_cubit.dart';
import 'package:chattest/featuers/contacts/logic/users_cubit.dart';
import 'package:chattest/featuers/home/logic/rooms_cubit.dart';
import 'package:chattest/featuers/login/logic/login_cubit.dart';
import 'package:chattest/featuers/register/logic/register_cubit.dart';
import 'package:chattest/featuers/register/ui/register_screen.dart';
import 'package:chattest/logic_myApp/theme/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/firebase_service/notifc.dart';
import 'firebase_options.dart';
import 'myApp.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Nofifcation().requestNotificationPermissions();

  await SharedPrefsHelper.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => RegisterCubit()),
    BlocProvider(create: (_) => ThemeCubit()),
    BlocProvider(create: (_) => LoginCubit()),
    BlocProvider(create: (_) => UsersCubit(FirebaseStoreService())),
    BlocProvider(create: (_) => RoomsCubit(FirebaseStoreService())),
    BlocProvider(create: (_) => ChatCubit(FirebaseStoreService())),

  ], child: const MyApp()));
}
