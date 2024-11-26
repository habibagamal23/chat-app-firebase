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
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final pickedFile =
            await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              registerCubit.setProfileImage(File(pickedFile.path));
            }
          },
          child: CircleAvatar(
            radius: 40.w,
            backgroundImage: registerCubit.profileImage != null
                ? FileImage(registerCubit.profileImage!)
                : null,
            child: registerCubit.profileImage == null
                ? Icon(Icons.camera_alt, size: 30.sp)
                : null,
          ),
        );
      },
    );
  }
}
