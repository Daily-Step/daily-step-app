import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class DailyStepAuth extends ChangeNotifier {
  bool _signedIn = false;
  bool _signedUp = false;
  DailyStepAuth(){}
  @override
  void dispose() {
    super.dispose();
  }

  /// Whether user has signed in.
  bool get signedIn => _signedIn;
  bool get signedUp => _signedUp;

  /// Signs out the current user.
  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = false;
    notifyListeners();
  }

  /// Signs in a user.
  Future<bool> googleSignIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }
  Future<bool> naverSignIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }
  Future<bool> kakaoSignIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  Future<bool> signUp() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedUp = true;
    notifyListeners();
    return _signedUp;
  }

  String? guard(BuildContext context, GoRouterState state) {
    final bool signedIn = this.signedIn;
    final bool signedUp = this.signedUp;

    if (!signedIn) {
      return '/signin';
    }
    else if(signedIn && !signedUp){
      return '/signUp';
    }
    else if (signedIn && signedUp) {
      return '/main/home';
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