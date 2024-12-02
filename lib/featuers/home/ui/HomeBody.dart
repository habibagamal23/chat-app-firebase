import 'package:chattest/featuers/home/ui/widgets/roomcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/firebase_service/firebase_store.dart';
import '../logic/rooms_cubit.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(builder: (context, state) {
      if (state is RoomsLoading) {
        return const CircularProgressIndicator();
      }

      if (state is RoomsSuceess) {
        return ListView.builder(
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              final room = state.rooms[index];
              final otherUserId = room.members.firstWhere(
                (id) => id != FirebaseStoreService().myUid,
                orElse: () => '',
              );
              final userProfile =
                  context.read<RoomsCubit>().getUserProfile(otherUserId);
              return UserCard(userProfile: userProfile!, room: room);
            });
      }

      if (state is RoomsFealier) {
        return Text(state.msg);
      }

      return const Text("no rooms");
    });
  }
}
