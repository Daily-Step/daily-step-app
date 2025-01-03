import 'package:flutter/material.dart';

class SizeUtil {
  static final SizeUtil _instance = SizeUtil._internal(); // 싱글턴 인스턴스 생성
  factory SizeUtil() => _instance; // 팩토리 생성자

  SizeUtil._internal(); // 프라이빗 생성자

  double su = 1;

  void setSizeUnitSafe() {
    const int designSize = 360;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      su = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
          WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio /
          designSize;

      if (su == 0) {
        su = 1;
      } else if (su >= 1.8) {
        su = 1.2;
      }

      debugPrint("size unit is $su");
    });
  }
}

double get su => SizeUtil().su;
