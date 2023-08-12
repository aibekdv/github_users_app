import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:github_users_app/presentation/bloc/bloc.dart';
import 'package:github_users_app/presentation/pages/pages.dart';
import 'package:github_users_app/presentation/widgets/widgets.dart';
import 'package:github_users_app/utils/service_locator.dart' as di;

import 'generated/l10n.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // INIT STATE
  @override
  void initState() {
    super.initState();
    // REMOVE SPLASH SCREEN AFTER 3 SECOND
    Future.delayed(
      const Duration(seconds: 3),
      () => FlutterNativeSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MULTIBLOC PROVIDER FOR USE SOME BLOCS
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => di.sl<UserCubit>(),
        ),
        BlocProvider<ConnectionCubit>(
          create: (context) => di.sl<ConnectionCubit>(),
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => di.sl<LanguageCubit>()..getCachedLanguage(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          Locale locale = const Locale('en');

          if (state is ChangeLanguage) {
            locale = state.locale;
          }

          return MaterialApp(
            title: 'GiHub Users App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
