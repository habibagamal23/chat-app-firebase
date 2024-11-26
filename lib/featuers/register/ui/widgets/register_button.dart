import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/router_constant.dart';
import '../../logic/register_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();

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
