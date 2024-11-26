part of 'contant_cubit.dart';

@immutable
sealed class ContantState {}

final class ContantInitial extends ContantState {}

final class UsersLoading extends ContantState {}

final class UsersLoaded extends ContantState {
  final List<UserModel> users;
  UsersLoaded(this.users);
}

final class UsersError extends ContantState {
  final String errormass;
  UsersError(this.errormass);
}
