
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/wigdtes/custom_form_feild.dart';
import '../logic/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: Form(
        key: loginCubit.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email Field
                CustomTextField(
                  controller: loginCubit.emailController,
                  label: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Password Field
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: loginCubit.passwordController,
                      label: 'Password',
                      obscureText: !loginCubit.isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginCubit.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 24.sp,
                        ),
                        onPressed: loginCubit.togglePasswordVisibility,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters.';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 32.h),

                // Login Button with State Handling
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login Successful!')),
                      );
                    } else if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: loginCubit.login,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}