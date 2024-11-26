import 'package:chattest/featuers/register/logic/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/wigdtes/custom_form_feild.dart';

class AllTextFeiled extends StatelessWidget {
  const AllTextFeiled({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();

    return Column(
      children: [
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
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return CustomTextField(
                controller: registerCubit.passcon,
                label: 'Password',
                obscureText: !registerCubit.isPasswordVisible,
                suffixIcon: IconButton(
                    icon: Icon(
                      registerCubit.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 24.sp,
                    ),
                    onPressed: registerCubit.togglePasswordVisibility),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password.';
                  }
                  return null;
                });
          },
        ),
      ],
    );
  }
}
