import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // 권한 요청
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.photos.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      // 모든 권한이 허용된 경우
      Future.delayed(Duration(milliseconds: 1500), () {
        if (mounted) {
          context.go('/main/home');
        }
      });
    } else {
      // 권한이 거부된 경우 사용자에게 알림
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('권한 필요'),
        content: Text(
            '앱을 사용하려면 카메라 및 저장소 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('닫기'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: Text('설정 열기'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 105.0),
        child: Center(
          child: Image.asset('assets/splash/splash_logo.png'),
        ),
      ),
    );
  }
}
