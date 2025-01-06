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
    _signedIn = true; // 로그인 상태 업데이트
    notifyListeners(); // 상태 변경 알림

    GoRouter.of(context).go('/main/home'); // 메인 화면 이동
  }

  String? guard(GoRouterState state) {
    final isLoginPage = state.matchedLocation == '/signIn' || state.matchedLocation == '/signUp';

    // 로그인되지 않은 경우
    if (!_signedIn && !isLoginPage) {
      return '/signIn';
    }

    // 로그인된 상태에서 로그인 페이지로 이동 차단
    if (_signedIn && isLoginPage) {
      return '/main/home';
    }

    return null; // 리디렉션 필요 없음
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
