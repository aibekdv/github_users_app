import 'package:dio/dio.dart';
import 'package:github_users_api/core/core.dart';
import 'package:github_users_api/feature/data/models/models.dart';
import 'package:github_users_api/feature/domain/domain.dart';

abstract class GithubRemoteDataSource {
  Future<DataState<List<UserEntity>>> getUsers({
    int page = 1,
    int perPage = 30,
  });
  Future<DataState<UserEntity>> getUser({required String userName});
}

class GithubRemoteDataSourceImpl implements GithubRemoteDataSource {
  final Dio _dio;

  GithubRemoteDataSourceImpl(this._dio);

  @override
  Future<DataState<UserEntity>> getUser({required String userName}) async {
    try {
      var response = await _dio.get('users/$userName');
      if ([200, 201].contains(response.statusCode)) {
        var data = response.data;

        return DataSuccess(UserModel.fromJson(data));
      } else {
        return DataFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<UserEntity>>> getUsers({
    int page = 1,
    int perPage = 30,
  }) async {
    try {
      var response = await _dio.get('users?since=$page&per_page=$perPage');
      if ([200, 201].contains(response.statusCode)) {
        List data = response.data;

        return DataSuccess(data.map((e) => UserModel.fromJson(e)).toList());
      } else {
        return DataFailed(
          DioException(
            error: response.statusMessage,
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
