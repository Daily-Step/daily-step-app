import 'package:dailystep/widgets/widget_height_and_width.dart';
import 'package:flutter/material.dart';

import '../common/util/size_util.dart';

class WAppColors {
  /// 7DF6FF
  static const Color mPrimary = Color(0xFF7DF6FF);

  /// 2F41F2
  static const Color secondary = Color(0xFF2F41F2);

  /// 2257FF
  static const Color secondary1 = Color(0xFF2257FF);

  /// 1D1D1D
  static const Color gray09 = Color(0xFF1D1D1D);

  /// 2D2D2D
  static const Color gray08 = Color(0xFF2D2D2D);

  /// 555555
  static const Color gray07 = Color(0xFF555555);

  /// 717171
  static const Color gray06 = Color(0xFF717171);

  /// 8E8E8E
  static const Color gray05 = Color(0xFF8E8E8E);

  /// C6C6C6
  static const Color gray04 = Color(0xFFC6C6C6);

  /// D8D8D8
  static const Color gray03 = Color(0xFFD8D8D8);

  /// F8F8F8
  static const Color gray02 = Color(0xFFF8F8F8);

  /// FFFFFF
  static const Color white = Color(0xFFFFFFFF);
}

class WAppTextStyle {
  /// Regular (400) 굵기
  static const FontWeight regular = FontWeight.w400;

  /// Normal (500) 굵기
  static const FontWeight normal = FontWeight.w500;

  /// SemiBold (600) 굵기
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold (700) 굵기
  static const FontWeight bold = FontWeight.w700;

  /// ExtraBold (800) 굵기
  static const FontWeight extraBold = FontWeight.w800;
}

class WAppFontSize {
  /// Title XXL (Bold, Size 32)
  static TextStyle titleXXL = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 32 * su,
    height: 1.5 * su,
  );

  /// Title XL (Bold, Size 25)
  static TextStyle titleXL = TextStyle(
    fontWeight: WAppTextStyle.bold,
    fontSize: 25 * su,
    height: 1.5 * su,
  );

  /// Title L (Bold, Size 21)
  static TextStyle titleL = TextStyle(
    fontWeight: WAppTextStyle.bold,
    fontSize: 21 * su,
    height: 1.5 * su,
  );

  /// Title M (Bold, Size 19)
  static TextStyle titleM = TextStyle(
    fontWeight: WAppTextStyle.bold,
    fontSize: 19 * su,
    height: 1.5 * su,
  );

  /// Title S (Bold, Size 17)
  static TextStyle titleS = TextStyle(
    fontWeight: WAppTextStyle.bold,
    fontSize: 17 * su,
    height: 1.5 * su,
  );

  static TextStyle bodyL1 = TextStyle(
    fontWeight: WAppTextStyle.semiBold,
    fontSize: 19 * su,
    height: 1.3 * su,
  );

  static TextStyle values = TextStyle(
    fontWeight: WAppTextStyle.regular,
    fontSize: 15 * su,
    height: 1.3 * su,
  );
}

const spacer = Spacer();

const width2 = Width(2);
const width5 = Width(5);
const width10 = Width(10);
const width20 = Width(20);
const width30 = Width(30);

const height2 = Height(2);
const height5 = Height(5);
const height10 = Height(10);
const height15 = Height(15);
const height20 = Height(20);
const height30 = Height(30);
const height40 = Height(40);
const height60 = Height(60);
const height70 = Height(70);
const height80 = Height(80);

const pickerFontSize = 24.0;
const detailDataFontSize = 18.0;
const subFontSize = 16.0;

/// 좌우 마진
const globalMargin = EdgeInsets.symmetric(horizontal: 20.0);

/// 박스 border radius
var globalBorderRadius = BorderRadius.circular(10);

/// 텍스트 스타일
var subTextStyle = TextStyle(fontSize: 12 ,color: Colors.grey.shade500);
var labelTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
var hintTextStyle = TextStyle(fontSize: 16 ,color: Colors.grey.shade400);
var contentTextStyle = TextStyle(fontSize: 16 ,color: Colors.grey.shade600);
var boldTextStyle = TextStyle(fontSize: detailDataFontSize ,fontWeight: FontWeight.bold);

/// 색상
var blackColor = Color(0xFF000000);
var disabledColor = Color(0xFFAFAFAF);
var subTextColor = Color(0xFF8E8E8E);
var primaryColor = Color(0xFF2F41F2);
var backgroundColor = Color(0xFFF8F8F8);
var bgGreyColor = Color(0xFFE0E0E0);


/// 그라디언트
const mainGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF15C5EC),
    Color(0xFF2F41F2),
  ],
  tileMode: TileMode.mirror,
);