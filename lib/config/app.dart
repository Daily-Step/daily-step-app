import 'package:dailystep/config/route/fade_transition_page.dart';
import 'package:dailystep/data/api/login_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/login_provider.dart';
import '../feature/auth/login_screen.dart';
import '../feature/home/view/challenge_detail_screen.dart';
import '../feature/home/view/challenge_edit_screen.dart';
import '../feature/main_screen.dart';
import '../feature/sign_up/sign_up_screen.dart';
import '../feature/nav/nav_item.dart';
import 'route/auth_redirection.dart';

class App extends ConsumerStatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with WidgetsBindingObserver {
  final DailyStepAuth _auth = DailyStepAuth(
      socialLoginRepository: SocialLoginRepository(),
      loginApi: LoginApi.instance);

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
            FadeTransitionPage(
                key: state.pageKey,
                child: SignUpScreen(
                  auth: _auth,
                )),
      ),
      GoRoute(
        path: '/main/:kind(home|calendar|chart|myPage)',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(
          key: state.pageKey,
          child: MainScreen(
            firstTab: TabItem.find(state.pathParameters['kind']),
          ),
        ),
        routes: <GoRoute>[
          GoRoute(
            path: 'challenge/new',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                FadeTransitionPage(
                  key: state.pageKey,
                  child: ChallengeEditScreen(null),
                ),
          ),
          GoRoute(
            path: 'challenge/edit/:id',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String id = state.pathParameters['id']!;
              return FadeTransitionPage(
                key: state.pageKey,
                child: ChallengeEditScreen(int.parse(id)),
              );
            },
          ),
          GoRoute(
            path: ':postId',
            builder: (BuildContext context, GoRouterState state) {
              final String postId = state.pathParameters['postId']!;
              return ChallengeDetailScreen(int.parse(postId));
            },
          ),
        ],
      ),
    ],
    redirect: _auth.guard,
    refreshListenable: _auth,
    debugLogDiagnostics: true,
  );
}
