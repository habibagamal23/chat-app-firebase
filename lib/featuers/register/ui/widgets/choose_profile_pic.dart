import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/register_cubit.dart';

class ChooseProfilePic extends StatelessWidget {
  const ChooseProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    return  BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final filepicker =
            await picker.pickImage(source: ImageSource.camera);
            if (filepicker != null) {
              registerCubit.setImage(File(filepicker.path));
            }
          },
          child: CircleAvatar(
              radius: 40.r,
              backgroundImage: registerCubit.proileimage != null
                  ? FileImage(registerCubit.proileimage! , )
                  : null,
              child: registerCubit.proileimage == null
                  ? Icon(
                Icons.camera,
                size: 30.sp,
              )
                  : null),
        );
      },
    );
  }
}
