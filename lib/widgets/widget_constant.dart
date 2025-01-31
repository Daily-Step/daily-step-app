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

  /// 000000
  static const Color black = Color(0xFF000000);

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

  /// E9E9E9
  static const Color gray04 = Color(0xFFE9E9E9);

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

/// 인자값 전달받아서 해당 색상 및 weight 변경
class WAppFontSize {
  /// Title XXL (Size 32, 기본값: Bold, 기본색: black)
  static TextStyle titleXXL({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.bold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 32 * su,
      height: 1.5,
      color: color,
    );
  }

  /// Title XL (Size 25, 기본값: Bold, 기본색: black)
  static TextStyle titleXL({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.bold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 25 * su,
      height: 1.5,
      color: color,
    );
  }

  /// Title L (Size 21, 기본값: Bold, 기본색: black)
  static TextStyle titleL({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.bold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 21 * su,
      height: 1.5,
      color: color,
    );
  }

  /// Title M (Size 19, 기본값: Bold, 기본색: black)
  static TextStyle titleM({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.bold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 19 * su,
      height: 1.5,
      color: color,
    );
  }

  /// Title S (Size 17, 기본값: Bold, 기본색: black)
  static TextStyle titleS({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.bold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 17 * su,
      height: 1.5,
      color: color,
    );
  }

  /// Body L1 (Size 19, 기본값: SemiBold, 기본색: black)
  static TextStyle bodyL1({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.semiBold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 19 * su,
      height: 1.3,
      color: color,
    );
  }

  /// Body bodyS1 (Size 15, 기본값: SemiBold, 기본색: gray05)
  static TextStyle bodyS1({Color color = WAppColors.gray05, FontWeight fontWeight = WAppTextStyle.semiBold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 15 * su,
      height: 1.3,
      color: color,
    );
  }

  /// label L1 (Size 17, 기본값: Bold, 기본색: gray05)
  static TextStyle labelL1({Color color = WAppColors.gray05, FontWeight fontWeight = WAppTextStyle.bold}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 17 * su,
      height: 1.3,
      color: color,
    );
  }

  /// Values (Size 15, 기본값: Regular, 기본색: gray05)
  static TextStyle values({Color color = WAppColors.gray05, FontWeight fontWeight = WAppTextStyle.regular}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 15 * su,
      height: 1.3,
      color: color,
    );
  }

  /// Values (Size 1, 기본값: Regular, 기본색: gray05)
  static TextStyle subValues({Color color = WAppColors.gray05, FontWeight fontWeight = WAppTextStyle.regular}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 13 * su,
      height: 1.3,
      color: color,
    );
  }

  /// Values (Size 11, 기본값: Regular, 기본색: black)
  static TextStyle navbar({Color color = WAppColors.black, FontWeight fontWeight = WAppTextStyle.regular}) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 11 * su,
      height: 1.3,
      color: color,
    );
  }
}

class WAppIconSvg {
  static const String homeActive = 'assets/icons/home.svg';
  static const String homeInactive = 'assets/icons/home_inactive.svg';
  static const String personActive = 'assets/icons/person.svg';
  static const String personInactive = 'assets/icons/person_inactive.svg';
}


const spacer = Spacer();

var width2 = Width(2 * su);
var width5 = Width(5 * su);
var width8 = Width(8 * su);
var width10 = Width(10 * su);
var width20 = Width(20 * su);
var width30 = Width(30 * su);

var height2 = Height(2 * su);
var height5 = Height(5 * su);
var height10 = Height(10 * su);
var height15 = Height(15 * su);
var height20 = Height(20 * su);
var height30 = Height(30 * su);
var height40 = Height(40 * su);
var height50 = Height(50 * su);
var height60 = Height(60 * su);
var height70 = Height(70 * su);
var height80 = Height(80 * su);

var pickerFontSize = 24.0 * su;
var detailDataFontSize = 18.0 * su;
var subFontSize = 16.0 * su;

/// 좌우 마진
var globalMargin = EdgeInsets.symmetric(horizontal: 20.0 * su);

/// 박스 border radius
var globalBorderRadius = BorderRadius.circular(14 * su);

/// 텍스트 스타일
var subTextStyle = TextStyle(fontSize: 15 * su ,color: Colors.grey.shade500);
var labelTextStyle = TextStyle(fontSize: 15 * su, fontWeight: FontWeight.w600);
var hintTextStyle = TextStyle(fontSize: 15 * su ,color: Colors.grey.shade400);
var contentTextStyle = TextStyle(fontSize: 15 * su ,color: Colors.grey.shade600);
var menuTextStyle = TextStyle(fontSize: 15 * su ,fontWeight: FontWeight.bold);
var boldTextStyle = TextStyle(fontSize: detailDataFontSize ,fontWeight: FontWeight.bold, color:blackColor );

/// 색상
var blackColor = Color(0xFF000000);
var disabledColor = Color(0xFFAFAFAF);
var subTextColor = Color(0xFF8E8E8E);
var primaryColor = Color(0xFF2F41F2);
var backgroundColor = Color(0xFFF8F8F8);
var bgGreyColor = Color(0xFFE0E0E0);
var borderColor =  Colors.grey.shade300;


/// 그라디언트
const mainGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xFF2F41F2),
    Color(0xFF7DF6FF),
  ],
  tileMode: TileMode.mirror,
);