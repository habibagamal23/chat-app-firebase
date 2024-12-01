import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/firebase_store.dart';
import 'package:chattest/featuers/contacts/model/user_Model.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.firebaseStoreService) : super(UsersInitial());

  FirebaseStoreService firebaseStoreService;
  StreamSubscription<List<UserModel>>? streamSubscription;
  void showAllusers() {
    emit(UsersLoading());
    streamSubscription = firebaseStoreService.getAllUser().listen((users) {
      emit(UsersSuccuss(users));
    }, onError: (e) {
      emit(UsersErorr("users listen is feluier $e"));
    });
  }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    // TODO: implement close
    return super.close();
  }
}
