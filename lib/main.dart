import 'package:chattest/core/sharedprefrance/shared_pref_helper.dart';
import 'package:chattest/featuers/login/logic/login_cubit.dart';
import 'package:chattest/featuers/register/logic/register_cubit.dart';
import 'package:chattest/featuers/register/ui/register_screen.dart';
import 'package:chattest/logic_myApp/theme/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featuers/content/logic/contant_cubit.dart';
import 'firebase_options.dart';
import 'myApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefsHelper.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => RegisterCubit()),
    BlocProvider(create: (_) => ThemeCubit()),
    BlocProvider(create: (_) => LoginCubit()),
    BlocProvider(create: (_) => ContantCubit()),

  ], child: const MyApp()));
}
