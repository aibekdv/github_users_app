import 'dart:convert';
import 'dart:developer';

import 'package:github_users_app/core/error/error.dart';
import 'package:github_users_app/data/models/models.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  static const baseUrl = 'https://api.github.com';

  Future<List<UserModel>> getUsers({int page = 1, int perPage = 30}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users?since=$page&per_page=$perPage'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List userList = jsonDecode(response.body);
        return userList.map((e) => UserModel.fromJson(e)).toList();
      } else {
        log(response.statusCode.toString());
        throw ServerExeption();
      }
    } catch (e) {
      log(e.toString());
      throw ServerExeption();
    }
  }

  Future<UserModel> getUser({required String userName}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userName'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = jsonDecode(response.body);
        return UserModel.fromJson(user);
      } else {
        log(response.statusCode.toString());
        throw ServerExeption();
      }
    } catch (e) {
      log(e.toString());
      throw ServerExeption();
    }
  }
}
