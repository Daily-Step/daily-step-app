import 'package:dailystep/feature/auth/social_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../feature/auth/social_login_repository.dart';
import '../../model/user/user_model.dart';

class DailyStepAuth extends ChangeNotifier {
  bool _signedIn = false;
  bool _signedUp = false;
  final SocialLoginRepository socialLoginRepository;

  UserModel? user;

  DailyStepAuth({required this.socialLoginRepository});

  bool get signedIn => _signedIn;

  bool get signedUp => _signedUp;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = false;
    _signedUp = false;
    notifyListeners();
  }

  Future<void> googleSignIn(BuildContext context) async {
    await socialLoginRepository.socialLogin(socialType: SocialType.google);
    signIn(context);
  }

  Future<void> naverSignIn(BuildContext context) async {
    await socialLoginRepository.socialLogin(socialType: SocialType.naver);
    signIn(context);
  }

  Future<void> kakaoSignIn(BuildContext context) async {
    await socialLoginRepository.socialLogin(socialType: SocialType.kakao);
    signIn(context);
  }

  Future<void> signUp(BuildContext context) async {
    _signedUp = true;
    _signedIn = true;
    notifyListeners();
    GoRouter.of(context).go('/main/home');
  }

  Future<void> signIn(BuildContext context) async {
    _signedIn = true;
    notifyListeners();

    // 로그인 후 라우팅 처리
    if (!signedUp) {
      GoRouter.of(context).go('/signUp');
    } else {
      // 이미 회원가입이 완료된 경우 메인 페이지 등으로 이동
      GoRouter.of(context).go('/main/home');
    }
  }

  String? guard(GoRouterState state, bool isLoggedIn) {
    final isLoginPage = state.matchedLocation == '/signIn' || state.matchedLocation == '/signUp';

    if (isLoggedIn) {
      // 로그인한 경우 로그인 또는 회원가입 페이지로 가는 것을 막고 홈으로 리디렉션
      if (isLoginPage) {
        return '/main/home';
      }
    }

    // 로그인되지 않은 경우 로그인 페이지로 리디렉션
    if (!isLoggedIn && !isLoginPage) {
      return '/signIn';
    }

    return null; // 리디렉션이 필요 없으면 null 반환
  }
}

class DailyStepAuthScope extends InheritedNotifier<DailyStepAuth> {
  const DailyStepAuthScope({
    required DailyStepAuth super.notifier,
    required super.child,
    super.key,
  });

  static DailyStepAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DailyStepAuthScope>()!
      .notifier!;
}
