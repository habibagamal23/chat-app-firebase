import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:meta/meta.dart';

import '../model/room.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit(this.storeService) : super(RoomsInitial());
  FirebaseStoreService storeService;

  Future creatroom(String ontherId) async {
    await storeService.creatRoom(ontherId);
    emit(RoomsCreated());
  }

  StreamSubscription<List<Room>>? streamSubscription;

  getRooms() {
    emit(RoomsLoading());

    streamSubscription = storeService.getMyRooms().listen((rooms) {
      print(rooms);
      emit(RoomsSuceess(rooms));
    }, onError: (e) {
      emit(RoomsFealier(e.toString()));
    });
  }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    // TODO: implement close
    return super.close();
  }
}
