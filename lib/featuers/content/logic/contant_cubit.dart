import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/FirebaseDataService.dart';
import 'package:chattest/featuers/content/model/user_Model.dart';
import 'package:meta/meta.dart';

part 'contant_state.dart';

class ContantCubit extends Cubit<ContantState> {
  ContantCubit() : super(ContantInitial());

  final FirebaseDataService fireBaseData = FirebaseDataService();

  StreamSubscription<List<UserModel>>? _streamSubscription;

  void fetchAlluserWithoutme() {
    emit(UsersLoading());
    _streamSubscription = fireBaseData.getAllUsersWithoutme().listen((users) {
      emit(UsersLoaded(users));
    }, onError: (e) {
      emit(UsersError(e.toString()));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
