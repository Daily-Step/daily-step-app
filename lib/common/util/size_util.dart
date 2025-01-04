import 'package:flutter/material.dart';

class SizeUtil {
  static final SizeUtil _instance = SizeUtil._internal(); // 싱글턴 인스턴스 생성
  factory SizeUtil() => _instance; // 팩토리 생성자

  SizeUtil._internal(); // 프라이빗 생성자

  double su = 1; // 단위 크기

  void setSizeUnit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
      final pixelRatio = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

      // 화면 크기 계산
      final screenWidth = size.width / pixelRatio; // dp 단위의 화면 너비
      final screenHeight = size.height / pixelRatio; // dp 단위의 화면 높이

      // 디자인 기준 (360x640)
      const designWidth = 382.0;
      const designHeight = 850.0;

      // 가로, 세로 비율 계산
      final widthUnit = screenWidth / designWidth;
      final heightUnit = screenHeight / designHeight;

      // 최소값으로 su 계산
      su = widthUnit < heightUnit ? widthUnit : heightUnit;

      debugPrint(
          "SizeUnit - su: $su, widthUnit: $widthUnit, heightUnit: $heightUnit, screenWidth: $screenWidth, screenHeight: $screenHeight");
    });
  }
}

// 전역적으로 접근 가능한 `su` 값
double get su => SizeUtil().su;
