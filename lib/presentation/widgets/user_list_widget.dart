import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users_app/data/models/models.dart';
import 'package:github_users_app/generated/l10n.dart';
import 'package:github_users_app/presentation/bloc/user/user_cubit.dart';
import 'package:github_users_app/presentation/widgets/widgets.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  final ScrollController scrollController = ScrollController();
  List<UserModel> users = [];

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<UserCubit>().loadUsers();
        }
      }
    });
  }

  @override
  void initState() {
    setupScrollController(context);
    context.read<UserCubit>().loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserListLoading) {
          log("message");
          return _loadingIndicator();
        } else if (state is UserListLoaded) {
          users = state.users;
        } else if (state is UserListError) {
          return Center(
            child: Text(
              S.of(context).somethingWrong,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemCount: users.isNotEmpty ? users.length + 1 : users.length,
          itemBuilder: (context, index) {
            if (index < users.length) {
              return UserItemWidget(userInfo: users[index]);
            } else {
              Timer(const Duration(microseconds: 100), () {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              });
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: _loadingIndicator(),
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey[400]);
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}
