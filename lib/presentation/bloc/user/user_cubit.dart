import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:github_users_app/core/error/exception.dart';
import 'package:meta/meta.dart';
import 'package:github_users_app/data/api/api.dart';
import 'package:github_users_app/data/models/models.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GithubApi githubApi;

  UserCubit(this.githubApi) : super(UserInitial());

  final List<UserModel> _loadedUsers = [];
  int _since = 0;

  void loadUsers() async {
    if (state is UserInitial) {
      emit(UserListLoading());
    }

    try {
      log(_since.toString());
      final users = await githubApi.getUsers(page: _since, perPage: 20);
      _loadedUsers.addAll(users);
      emit(UserListLoaded(_loadedUsers));
      _since = _loadedUsers.last.id!;
    } catch (_) {
      emit(UserListError());
    }
  }

  getSingleUser(String userName) async {
    emit(SingleUserLoading());
    try {
      UserModel user = await githubApi.getUser(userName: userName);
      emit(SingleUserLoaded(user));
    } catch (e) {
      emit(SingleUserError());
    }
  }
}
