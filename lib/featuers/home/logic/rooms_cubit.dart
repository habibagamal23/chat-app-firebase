import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:meta/meta.dart';

import '../model/room.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit(this.storeService) : super(RoomsInitial());
  FirebaseStoreService storeService;

  Future creatroom(String ontherId) async {
    await storeService.createRoom(ontherId);
    emit(RoomsCreated());
  }

  StreamSubscription<List<Room>>? streamSubscription;

  getRooms() {
    emit(RoomsLoading());

    streamSubscription = storeService.getAllRooms().listen((rooms) {
      emit(RoomsSuceess(rooms));
    }, onError: (e) {
      emit(RoomsFealier(e.toString()));
    });
  }

  List<UserModel> _cachedUsers = [];

  StreamSubscription<List<UserModel>>? _usersSubscription;

  Future<void> fetchAllData() async {
    emit(RoomsLoading());
    try {
      _usersSubscription = storeService.getAllUser().listen((users) {
        _cachedUsers = users;
        print('Fetched users');
        getRooms();
      });
    } catch (e) {
      emit(RoomsFealier('Error fetching users: $e'));
    }
  }

  UserModel? getUserProfile(String userId) {
    try {
      return _cachedUsers.firstWhere(
        (user) => user.id == userId,
        orElse: () => UserModel(
          id: "",
          name: "Unknown User",
          email: "",
          about: "",
          phoneNumber: "",
          createdAt: "",
          lastActivated: "",
          pushToken: "",
          online: false,
        ),
      );
    } catch (e) {
      print('User not found: $userId');
      return null;
    }
  }

  @override
  Future<void> close() {
    _usersSubscription!.cancel();
    streamSubscription!.cancel();
    // TODO: implement close
    return super.close();
  }
}
