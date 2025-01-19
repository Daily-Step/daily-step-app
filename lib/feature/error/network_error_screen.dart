import 'package:dailystep/config/route/go_router.dart';
import 'package:dailystep/widgets/widget_buttons.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

import '../../common/util/size_util.dart';

class NetworkErrorScreen extends StatefulWidget {
  @override
  _NetworkErrorScreenState createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends State<NetworkErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: WCtaButton('뒤로가기', onPressed: (){
          navigateToPage('/');
        }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 105.0 * su),
            child: Center(
              child: Icon(Icons.error,size: 80, color: Colors.orange,)
            ),
          ),
          height10,
          Text('네트워크 오류가 발생했습니다.', style: WAppFontSize.titleM(),),
              height10,
          Text('서버에 접속할 수 없습니다.\n네트워크 연결을 확인해주세요.', textAlign: TextAlign.center,style: subTextStyle,)
        ]),
      ),
    );
  }
}
