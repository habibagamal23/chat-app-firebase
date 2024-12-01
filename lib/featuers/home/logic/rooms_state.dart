part of 'rooms_cubit.dart';

@immutable
sealed class RoomsState {}

final class RoomsInitial extends RoomsState {}

final class RoomsLoading extends RoomsState {}

final class RoomsSuceess extends RoomsState {
  List<Room> rooms;

  RoomsSuceess(this.rooms);
}

final class RoomsFealier extends RoomsState {
  String msg;
  RoomsFealier(this.msg);
}

final class RoomsCreated extends RoomsState {}
