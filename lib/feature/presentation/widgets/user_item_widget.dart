import 'package:flutter/material.dart';
import 'package:github_users_api/feature/domain/entities/entities.dart';
import 'package:github_users_api/feature/presentation/presentation.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({super.key, required this.userInfo});
  final UserEntity userInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        userInfo.login!.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(userName: userInfo.login!),
          ),
        );
      },
      leading: ClipOval(
        child: userInfo.avatarUrl != null
            ? Image.network(
                userInfo.avatarUrl!,
                width: 50,
                height: 50,
              )
            : Image.asset(
                "assets/no_image.png",
                width: 50,
                height: 50,
              ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}