import 'package:flutter/material.dart';

import '../../../../widgets/widget_constant.dart';

class CustomColor {
  final Color color;
  final String name;

  CustomColor({required this.color, required this.name});

  Widget get widget => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        width5,
        Text(
          name,
          style: contentTextStyle,
        )
      ]);
}

List<CustomColor> customColors = [
  CustomColor(color: Colors.red, name: '빨강'),
  CustomColor(color: Colors.orange, name: '주황'),
  CustomColor(color: Colors.lightGreen, name: '초록'),
  CustomColor(color: Colors.blue, name: '파랑'),
  CustomColor(color: Colors.purple, name: '보라'),
];
