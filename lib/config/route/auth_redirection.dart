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

  void signOut() {
    _signedIn = false;
    _signedUp = false;
    notifyListeners();
  }

  void signUp(BuildContext context){
    _signedUp = true;
    _signedIn = true;
    notifyListeners();
    GoRouter.of(context).go('/main/home');
  }

  void signIn(BuildContext context) {
    _signedIn = true; // 로그인 상태 업데이트
    notifyListeners(); // 상태 변경 알림

    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).go('/main/home'); // 메인 화면 이동
    });
  }

  String? guard(GoRouterState state) {
    final isLoginPage = state.matchedLocation == '/signIn' || state.matchedLocation == '/signUp';

    if (_signedIn && isLoginPage) {
      return '/main/home'; // 이미 로그인된 경우 홈으로 리디렉션
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
