import 'package:dailystep/config/route/fade_transition_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/login_screen.dart';
import '../feature/main_screen.dart';
import '../feature/sign_up/sign_up_screen.dart';
import '../feature/tab/tab_item.dart';
import 'auth.dart';

class App extends ConsumerStatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with WidgetsBindingObserver {
  final DailyStepAuth _auth = DailyStepAuth();
  final ValueKey<String> _scaffoldKey = const ValueKey<String>('App scaffold');

  @override
  Widget build(BuildContext context) {
    return DailyStepAuthScope(
      notifier: _auth,
      child: MaterialApp.router(
        locale: const Locale('ko'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: _router,
      ),
    );
  }

  late final GoRouter _router = GoRouter(
    navigatorKey: App.navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        redirect: (_, __) => '/main/home',
      ),
      GoRoute(
        path: '/signIn',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
                key: state.pageKey, child: LoginScreen(auth: _auth)),
      ),
      GoRoute(
        path: '/signUp',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(key: state.pageKey, child: SignUpScreen(auth: _auth,)),
      ),
      GoRoute(
        path: '/post/:postId',
        redirect: (BuildContext context, GoRouterState state) =>
            '/main/home/${state.pathParameters['postId']}',
      ),
      GoRoute(
        path: '/main/:kind(home|calendar|chart|myPage)',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
          key: _scaffoldKey,
          child: MainScreen(
            firstTab: TabItem.find(state.pathParameters['kind']),
          ),
        ),
      ),
    ],
    redirect: _auth.guard,
    refreshListenable: _auth,
    debugLogDiagnostics: true,
  );
}
