import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users_api/feature/domain/entities/entities.dart';
import 'package:github_users_api/feature/presentation/presentation.dart';
import 'package:github_users_api/generated/l10n.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final String userName;

  const DetailPage({super.key, required this.userName});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late UserEntity currentUser;

  @override
  void initState() {
    context.read<UsersApiCubit>().getSingleUser(widget.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).detailPage),
      ),
      body: BlocBuilder<UsersApiCubit, UsersApiState>(
        builder: (context, state) {
          if (state is SingleUserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SingleUserLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Center(
                    child: ClipOval(
                      child: Image.network(
                        state.user.avatarUrl!,
                        width: 165,
                        height: 165,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.user.login!.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.user.bio ?? S.of(context).noDescription,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${S.of(context).location}: ${state.user.location ?? 'undefined'}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${S.of(context).created} ${DateFormat("yMMMd").format(
                      DateTime.parse(state.user.createdAt!),
                    )}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(S.of(context).somethingWrong),
            );
          }
        },
      ),
    );
  }
}