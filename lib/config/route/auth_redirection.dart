import 'package:dailystep/feature/auth/social_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/api/login_api.dart';
import '../../feature/auth/social_login_repository.dart';
import '../../feature/auth/viewmodel/login_viewmodel.dart';
import '../../model/user/user_model.dart';

class DailyStepAuth extends ChangeNotifier {
  bool _signedIn = false;
  bool _signedUp = false;
  final SocialLoginRepository socialLoginRepository;
  final LoginApi loginApi;

  UserModel? user;

  DailyStepAuth({required this.socialLoginRepository, required this.loginApi});

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
    final isSignupPage = state.matchedLocation == '/signUp';

    if (isLoggedIn) {
      // 로그인 상태에서 로그인 또는 가입 페이지에 접근하면 홈으로 리디렉션
      if (isLoginPage || state.matchedLocation == '/') {
        return '/main/home';
      }
      if (isSignupPage) {
        return '/main/home';
      }
    }

    // 로그인 안 된 상태에서 로그인 페이지 외 다른 페이지 접근 시 로그인 페이지로 리디렉션
    if (!isLoggedIn && state.matchedLocation != '/signIn' && state.matchedLocation != '/signUp') {
      return '/signIn';
    }

    return null;  // 리디렉션 없이 그대로 페이지 유지
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
