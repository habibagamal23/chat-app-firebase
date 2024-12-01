import 'package:chattest/featuers/home/logic/rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../model/user_Model.dart';

class CardSelectedUsers extends StatelessWidget {
  final UserModel userProfile;

  const CardSelectedUsers({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final DateTime lastActivated = DateTime.parse(userProfile.lastActivated);
    final formattedTime = DateFormat.jm().format(lastActivated);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 7.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(12.r), // Rounded corners for the effect
          onTap: () {
            context.read<RoomsCubit>().creatroom(userProfile.id);
            context.pop();
          },
          child: Card(
            elevation: 5.0.sp,
            shadowColor: Colors.black45,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r), // Rounded corners
            ),
            color: Colors.white,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              title: Text(
                userProfile.name,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                userProfile.phoneNumber,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              trailing: Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blueGrey,
                ),
              ),
              hoverColor: Colors.blue.shade100,
              focusColor: Colors.blue.shade200,
              selectedColor: Colors.blue.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
