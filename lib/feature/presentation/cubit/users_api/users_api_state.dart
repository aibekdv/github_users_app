part of 'users_api_cubit.dart';

abstract class UsersApiState extends Equatable {
  const UsersApiState();

  @override
  List<Object> get props => [];
}

class UsersApiInitial extends UsersApiState {}

class UserListLoading extends UsersApiState {}

class UserListError extends UsersApiState {
  final DioException error;

  const UserListError({required this.error});

  @override
  List<Object> get props => [error];
}

class UserListLoaded extends UsersApiState {
  final List<UserEntity> users;

  const UserListLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class SingleUserLoading extends UsersApiState {}

class SingleUserLoaded extends UsersApiState {
  final UserEntity user;

  const SingleUserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class SingleUserError extends UsersApiState {
  final DioException error;

  const SingleUserError({required this.error});

  @override
  List<Object> get props => [error];
}
