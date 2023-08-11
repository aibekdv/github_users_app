import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users_app/generated/l10n.dart';
import 'package:github_users_app/presentation/bloc/bloc.dart';
import 'package:github_users_app/presentation/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String langCode = 'en';

  @override
  void initState() {
    super.initState();
    langCode = context.read<LanguageCubit>().getCachedLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).users),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            padding: const EdgeInsets.all(0),
            enableFeedback: false,
            icon: Row(
              children: [
                Text(
                  langCode.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                ),
              ],
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage("en");
                    langCode =
                        context.read<LanguageCubit>().getCachedLanguage();
                    setState(() {});
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "English",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage("ru");
                    langCode =
                        context.read<LanguageCubit>().getCachedLanguage();
                    setState(() {});
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Русский",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const UserListWidget(),
    );
  }
}
