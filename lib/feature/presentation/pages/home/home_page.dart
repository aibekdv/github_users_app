import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users_api/feature/presentation/presentation.dart';
import 'package:github_users_api/generated/l10n.dart';

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
    langCode = context.read<LangCubit>().getCachedLanguage();
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
                    context.read<LangCubit>().changeLanguage("en");
                    langCode =
                        context.read<LangCubit>().getCachedLanguage();
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
                    context.read<LangCubit>().changeLanguage("ru");
                    langCode =
                        context.read<LangCubit>().getCachedLanguage();
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