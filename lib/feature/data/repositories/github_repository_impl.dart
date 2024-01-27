import 'package:github_users_api/core/resources/data_state.dart';
import 'package:github_users_api/feature/data/datasources/remote/github_remote_data_source.dart';
import 'package:github_users_api/feature/domain/domain.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubRemoteDataSource _remoteDataSource;

  GithubRepositoryImpl(this._remoteDataSource);

  @override
  Future<DataState<UserEntity>> getUser({required String userName}) async =>
      await _remoteDataSource.getUser(userName: userName);

  @override
  Future<DataState<List<UserEntity>>> getUsers({
    int page = 1,
    int perPage = 30,
  }) async =>
      await _remoteDataSource.getUsers(page: page, perPage: perPage);
}
