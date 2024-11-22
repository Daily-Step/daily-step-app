import 'package:dailystep/widgets/widget_height_and_width.dart';
import 'package:flutter/material.dart';

const spacer = Spacer();

const width5 = Width(5);
const width10 = Width(10);
const width20 = Width(20);
const width30 = Width(30);

const height5 = Height(5);
const height10 = Height(10);
const height15 = Height(15);
const height20 = Height(20);
const height30 = Height(30);
const height60 = Height(60);

/// 좌우 마진
const globalMargin = EdgeInsets.symmetric(horizontal: 20.0);

/// 박스 border radius
var globalBorderRadius = BorderRadius.circular(2);

/// 텍스트 스타일
var labelTextStyle = TextStyle(fontSize: 14, color: Colors.black54);
var hintTextStyle = TextStyle(fontSize: 16 ,color: Colors.grey.shade400);
var contentTextStyle = TextStyle(fontSize: 16 ,color: Colors.grey.shade900);

/// 색상
var blackColor = Color(0xFF000000);
var disabledColor = Color(0xFFD8D8D8);
var mainColor = Color(0xFF2F41F2);