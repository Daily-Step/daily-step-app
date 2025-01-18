import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/view/login_screen.dart';
import '../../feature/error/error_screen.dart';
import '../../feature/home/view/challenge_detail_screen.dart';
import '../../feature/home/view/challenge_edit_screen.dart';
import '../../feature/main_screen.dart';
import '../../feature/mypage/view/settings/account_settings/account_setting_screen.dart';
import '../../feature/mypage/view/settings/edit_my_info_settings/birthday_settings/birthday_screen.dart';
import '../../feature/mypage/view/settings/edit_my_info_settings/gender_settings/gender_screen.dart';
import '../../feature/mypage/view/settings/edit_my_info_settings/job_settings/job_screen.dart';
import '../../feature/mypage/view/settings/edit_my_info_settings/jobtenure/jobtenure_screen.dart';
import '../../feature/mypage/view/settings/edit_my_info_settings/my_info_screen.dart';
import '../../feature/mypage/view/settings/edit_my_info_settings/nickname_settings/nickname_screen.dart';
import '../../feature/mypage/view/settings/version_info/version_info_screen.dart';
import '../../feature/nav/nav_item.dart';
import '../../feature/sign_up/view/sign_up_screen.dart';
import '../../feature/splash/splash_screen.dart';
import 'auth_redirection.dart';
import 'fade_transition_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final DailyStepAuth auth = DailyStepAuth();

void navigateToPage(String path) {
  final context = navigatorKey.currentContext;
  if (context != null) {
    context.go(path);
  }
}

GoRouter router(bool isLoggedIn) {
  return GoRouter(
    navigatorKey: navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
          key: state.pageKey,
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: '/error',
        pageBuilder: (BuildContext context, GoRouterState state) =>
            FadeTransitionPage(key: state.pageKey, child: ErrorScreen()),
      ),
      GoRoute(
        path: '/signIn',
        pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(key: state.pageKey, child: LoginScreen()),
      ),
      GoRoute(
        path: '/signUp',
        pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
          key: state.pageKey,
          child: SignUpScreen(
            auth: auth,
          ),
        ),
      ),
      GoRoute(
        path: '/main/home',
        pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
          key: state.pageKey,
          child: MainScreen(),
        ),
      ),
      GoRoute(
        path: '/main/home/:id',
        pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
          key: state.pageKey,
          child: MainScreen(id: int.parse(state.pathParameters['id']!)), // id를 MainScreen에 전달
        ),
      ),
      GoRoute(
        path: '/main/:kind(challenge|myPage)',
        pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
          key: state.pageKey,
          child: MainScreen(
            firstTab: TabItem.find(state.pathParameters['kind']),
          ),
        ),
        routes: <GoRoute>[
          GoRoute(
            path: '/new',
            pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
              key: state.pageKey,
              child: ChallengeEditScreen(null),
            ),
          ),
          GoRoute(
            path: '/edit/:id',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String id = state.pathParameters['id']!;
              return FadeTransitionPage(
                key: state.pageKey,
                child: ChallengeEditScreen(int.parse(id)),
              );
            },
          ),
          GoRoute(
            path: '/myinfo',
            pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(key: state.pageKey, child: MyInfoScreen()),
          ),
          GoRoute(
              path: '/myinfo/nickname/:nickname',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final String nicknameId = state.pathParameters['nickname']!;
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: NickNameScreen(
                    initialNickname: nicknameId,
                  ),
                );
              }),
          GoRoute(
            path: '/myinfo/birthday/:birthday',
            pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
              key: state.pageKey,
              child: BirthdayScreen(),
            ),
          ),
          GoRoute(
            path: '/myinfo/gender',
            pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
              key: state.pageKey,
              child: GenderScreen(),
            ),
          ),
          GoRoute(
            path: '/myinfo/job',
            pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
              key: state.pageKey,
              child: JobScreen(),
            ),
          ),
          GoRoute(
            path: '/myinfo/jobTenure',
            pageBuilder: (BuildContext context, GoRouterState state) => FadeTransitionPage(
              key: state.pageKey,
              child: JobTenureScreen(),
            ),
          ),
          GoRoute(
            path: '/:postId',
            builder: (BuildContext context, GoRouterState state) {
              final String postId = state.pathParameters['postId']!;
              return ChallengeDetailScreen(int.parse(postId));
            },
          ),
          GoRoute(
            path: 'myinfo/account_settings/:account',
            pageBuilder: (BuildContext context, GoRouterState state) =>
                FadeTransitionPage(key: state.pageKey, child: AccountSettingScreen()),
          ),
          GoRoute(
            path: 'version/:version',
            pageBuilder: (BuildContext context, GoRouterState state) {
              final String version = state.pathParameters['version']!;

              if (version == 'version_info') {
                return FadeTransitionPage(key: state.pageKey, child: VersionInfoScreen());
              }
              try {
                final int versionNumber = int.parse(version);
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    appBar: AppBar(title: Text('버전: $version')),
                    body: Center(
                      child: Text('버전 정보: $versionNumber'),
                    ),
                  ),
                );
              } catch (e) {
                return FadeTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    appBar: AppBar(title: Text('잘못된 버전')),
                    body: Center(
                      child: Text('처리할 수 없는 버전입니다: $version'),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return auth.guard(state);
    },
    refreshListenable: auth,
    debugLogDiagnostics: true,
  );
}