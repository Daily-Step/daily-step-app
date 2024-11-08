import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

class VersionInfoScreen extends StatelessWidget {
  const VersionInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Text('앱 버전정보'),
        leading: IconButton(
          onPressed: () {
            context.go('/main/myPage'); // 이전 페이지로 가는 대신 올바른 경로로 이동
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Center(
        child: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final packageInfo = snapshot.data; // 데이터가 있을 경우 사용
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Daliy_Step',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'ver ${packageInfo?.version ?? ""}', // 데이터가 없을 경우 기본 메시지 표시
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
