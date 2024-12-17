import 'package:dailystep/widgets/widget_height_and_width.dart';
import 'package:flutter/material.dart';

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