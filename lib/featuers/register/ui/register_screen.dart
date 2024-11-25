import 'package:chattest/featuers/register/logic/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/router_constant.dart';
import '../../../core/wigdtes/custom_form_feild.dart';
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
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: registerCubit.usernamecon,
                  label: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: registerCubit.emailcon,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: registerCubit.phoneecon,
                  label: 'Phone Number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                buildPasswordField(registerCubit),
                SizedBox(height: 32.h),
                buildRegisterButton(registerCubit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileImagePicker(RegisterCubit registerCubit) {
    return Center();
  }

  Widget buildPasswordField(RegisterCubit registerCubit) {
    // not  complete to toggle by press on icon
    return CustomTextField(
        controller: registerCubit.passcon,
        label: 'Password',
        obscureText: true,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.visibility,
            size: 24.sp,
          ),
          onPressed: () {},
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password.';
          }
          return null;
        });
  }

  Widget buildRegisterButton(RegisterCubit registerCubit) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
          context.go(RouterConstant.login);
        } else if (state is RegisterFeliuer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.err)),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const CircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: registerCubit.register,
          child: Text('Register', style: TextStyle(fontSize: 18.sp)),
        );
      },
    );
  }
}
