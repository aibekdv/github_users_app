import 'package:github_users_api/core/core.dart';
import 'package:github_users_api/feature/domain/entities/user_entity.dart';

abstract class GithubRepository{
  Future<DataState<List<UserEntity>>> getUsers({int page = 1, int perPage = 30});
  Future<DataState<UserEntity>> getUser({required String userName});
}