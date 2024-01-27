import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:github_users_api/generated/l10n.dart';
import 'feature/presentation/presentation.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
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
        BlocProvider<UsersApiCubit>(
          create: (context) => di.sl<UsersApiCubit>(),
        ),
        BlocProvider<ConnectivityCubit>(
          create: (context) => di.sl<ConnectivityCubit>(),
        ),
        BlocProvider<LangCubit>(
          create: (context) => di.sl<LangCubit>()..getCachedLanguage(),
        ),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: (context, connectivityState) {
          return BlocBuilder<LangCubit, LangState>(
            builder: (context, langState) {
              
              Locale locale = const Locale('en');

              if (langState is ChangeLanguage) {
                locale = langState.locale;
              }

              return MaterialApp(
                title: 'GitHub Users Api',
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
                home: connectivityState == ConnectivityState.connected
                    ? const HomePage()
                    : const NoInternetPage(),
              );
            },
          );
        },
      ),
    );
  }
}
