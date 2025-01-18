import 'package:dailystep/config/route/go_router.dart';
import 'package:dailystep/feature/auth/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/widget_constant.dart';
import 'route/auth_redirection.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerStateKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget with WidgetsBindingObserver {
  App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loginViewModelProvider).isLoggedIn;

    return DailyStepAuthScope(
      notifier: auth,
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldMessengerStateKey,
        locale: const Locale('ko'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: backgroundColor,
          ),
          fontFamily: 'Suit',
        ),
        routerConfig: router(isLoggedIn),
      ),
    );
  }
}
