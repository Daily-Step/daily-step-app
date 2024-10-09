import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class DailyStepAuth extends ChangeNotifier {
  bool _signedIn = false;
  DailyStepAuth(){}
  @override
  void dispose() {
    super.dispose();
  }

  /// Whether user has signed in.
  bool get signedIn => _signedIn;

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
  Future<bool> appleSignIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }
  Future<bool> cacaoSignIn() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  String? guard(BuildContext context, GoRouterState state) {
    final bool signedIn = this.signedIn;
    final bool signingIn = state.matchedLocation == '/signin';

    if (!signedIn && !signingIn) {
      return '/signin';
    }
    else if (signedIn && signingIn) {
      return '/';
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