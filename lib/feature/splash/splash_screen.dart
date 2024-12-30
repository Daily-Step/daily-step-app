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
    PermissionStatus galleryPermission;

    if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
      // 권한이 이미 허용된 경우
      context.go('/main/home');
      return;
    }

    // Android 13(API 33) 이상인지 확인 후 권한 요청
    if (await Permission.photos.isRestricted || await Permission.photos.isPermanentlyDenied) {
      _showPermissionDialog();
      return;
    } else if (await Permission.photos.isDenied) {
      galleryPermission = await Permission.photos.request(); // Android 13 이상
    } else {
      galleryPermission = await Permission.storage.request(); // Android 12 이하
    }

    if (galleryPermission.isGranted) {
      // 권한 허용된 경우
      context.go('/main/home');
    } else {
      // 권한 거부된 경우
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('권한 필요'),
        content: Text(
            '앱을 사용하려면 갤러리 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.'),
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
