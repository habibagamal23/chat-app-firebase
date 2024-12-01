part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersSuccuss extends UsersState {
  List<UserModel> users;
  UsersSuccuss(this.users);
}

final class UsersErorr extends UsersState {
  String msg;
  UsersErorr(this.msg);
}
