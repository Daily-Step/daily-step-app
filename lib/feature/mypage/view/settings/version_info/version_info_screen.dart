import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/util/size_util.dart';

class VersionInfoScreen extends StatelessWidget {
  const VersionInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text('버전 정보', style: WAppFontSize.titleXL(),),
        leading: IconButton(
          onPressed: () {
            context.go('/main/myPage'); // 이전 페이지로 가는 대신 올바른 경로로 이동
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            final packageInfo = snapshot.data; // 데이터가 있을 경우 사용
            return Padding(
              padding: EdgeInsets.all(16.0 * su),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝으로 배치
                    children: [
                      Text(
                        '${packageInfo?.version ?? ""}', // 데이터가 없을 경우 기본 메시지 표시
                        style: WAppFontSize.values(color: WAppColors.black),
                      ),
                      // TODO : 배포 후 스토어 파싱해서 최신 여부 판별 해야
                      Text(
                        '최신 버전입니다',
                        style: WAppFontSize.values(),
                      ),
                    ],
                  ),
                  Divider(), // Row 외부에 위치
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
