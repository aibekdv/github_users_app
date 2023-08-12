part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserListLoading extends UserState {}

class UserListError extends UserState {}

class UserListLoaded extends UserState {
  final List<UserModel> users;

  UserListLoaded(this.users);
}

class SingleUserLoading extends UserState {}

class SingleUserLoaded extends UserState {
  final UserModel user;

  SingleUserLoaded(this.user);
}

class SingleUserError extends UserState {}
