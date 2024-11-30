import 'dart:io';

import 'package:chattest/featuers/register/logic/register_cubit.dart';
import 'package:chattest/featuers/register/ui/widgets/all_text_feiled.dart';
import 'package:chattest/featuers/register/ui/widgets/choose_profile_pic.dart';
import 'package:chattest/featuers/register/ui/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../logic_myApp/theme/theme_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    themeCubit.ToggleTheme();
                  },
                  icon: Icon(state is ThemeIsDark
                      ? Icons.light_mode
                      : Icons.dark_mode));
            },
          )
        ],
        title: Text('Register', style: TextStyle(fontSize: 20.sp)),
      ),
      body: Form(
        key: registerCubit.keyform,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ChooseProfilePic(),
                SizedBox(height: 16.h),
                const AllTextFeiled(),
                SizedBox(height: 32.h),
                const RegisterButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
