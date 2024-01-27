import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users_api/core/core.dart';
import 'package:github_users_api/feature/domain/entities/user_entity.dart';
import 'package:github_users_api/feature/domain/repositories/repositories.dart';

part 'users_api_state.dart';

class UsersApiCubit extends Cubit<UsersApiState> {
  final GithubRepository _githubRepository;
  UsersApiCubit(this._githubRepository) : super(UsersApiInitial());

  final List<UserEntity> _loadedUsers = [];
  int _since = 0;

  void loadUsers() async {
    if (state is UsersApiInitial) {
      emit(UserListLoading());
    }

    final dataState =
        await _githubRepository.getUsers(page: _since, perPage: 20);

    if (dataState is DataSuccess) {
      _loadedUsers.addAll(dataState.data ?? []);
      emit(UserListLoaded(_loadedUsers));
      _since = _loadedUsers.last.id!;
    }

    if (dataState is DataFailed) {
      emit(UserListError(error: dataState.error!));
    }
  }

  getSingleUser(String userName) async {
    emit(SingleUserLoading());
    var dataState = await _githubRepository.getUser(userName: userName);

    if (dataState is DataSuccess) {
      emit(SingleUserLoaded(dataState.data!));
    }
    if (dataState is DataSuccess) {
      if (dataState.error != null) {
        emit(SingleUserError(error: dataState.error!));
      }
    }
  }
}
