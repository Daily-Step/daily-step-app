import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/util/size_util.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToSignIn();
  }

  Future<void> _navigateToSignIn() async {
    print('Delaying for 2 seconds');
    await Future.delayed(const Duration(seconds: 2));
    print('Navigating to /signIn');
    context.go('/signIn');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WAppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 105.0 * su),
              child: Center(
                child: Image.asset('assets/splash/splash_logo.png'),
              ),
            ),
            SizedBox(height: 20 * su),
          ],
        ),
      ),
    );
  }
}
