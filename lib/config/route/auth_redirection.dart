import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../model/user/user_model.dart';

class DailyStepAuth extends ChangeNotifier {
  bool _signedIn = false;
  bool _signedUp = false;

  UserModel? user;

  DailyStepAuth();

  bool get signedIn => _signedIn;
  bool get signedUp => _signedUp;

  /// ✅ 로그아웃: 회원가입 및 로그인 상태 초기화
  void signOut() {
    _signedIn = false;
    _signedUp = false;
    user = null;
    notifyListeners();
  }

  /// ✅ 회원가입 진행 (이 단계에서는 회원가입 화면 유지)
  void signUp() {
    _signedUp = true;
    notifyListeners();
  }

  /// ✅ 회원가입 완료 후 로그인 처리
  void completeSignUp(BuildContext context) {
    _signedUp = false;
    _signedIn = true;
    notifyListeners();

    Future.microtask(() {
      if (context.mounted) {
        print("✅ 회원가입 완료! 홈으로 이동");
        GoRouter.of(context).go('/main/home');
      }
    });
  }

  /// ✅ 로그인 성공 처리
  void signIn(BuildContext context) {
    _signedIn = true;
    _signedUp = false;
    notifyListeners();

    Future.microtask(() {
      if (context.mounted) {
        print("✅ 로그인 성공! 홈으로 이동");
        GoRouter.of(context).go('/main/home');
      }
    });
  }

  /// ✅ `GoRouter`의 리디렉션 로직
  String? guard(GoRouterState state) {
    final isLoginPage = state.matchedLocation == '/signIn';
    final isSignUpPage = state.matchedLocation == '/signUp';

    // ✅ 회원가입 중이면 `/signUp` 유지
    if (_signedUp && isSignUpPage) {
      return null;
    }

    // ✅ 로그인된 경우 로그인 & 회원가입 페이지에서 홈으로 이동
    if (_signedIn && (isLoginPage || isSignUpPage)) {
      return '/main/home';
    }

    // ✅ 로그인되지 않았고, 회원가입도 안 한 경우 로그인 페이지로 이동
    if (!_signedIn && !_signedUp && !isSignUpPage) {
      return '/signIn';
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
