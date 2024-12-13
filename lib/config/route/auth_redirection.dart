import 'package:dailystep/feature/auth/social_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../data/api/login_api.dart';
import '../../feature/auth/social_login_repository.dart';
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
    notifyListeners();
    GoRouter.of(context).go('/main/home');
  }

  Future<void> signIn(BuildContext context) async {
    user = await loginApi.me();
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

  String? guard(BuildContext context, GoRouterState state) {
    final bool signedIn = this.signedIn;
    final bool signedUp = this.signedUp;
    final location = state.uri.path;

    if (location == '/signIn' || location == '/signUp') {
      return null;
    }
    if (!signedIn) {
      return '/signIn';
    } else if (signedIn && !signedUp) {
      return '/signUp';
    }
    return null;
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
