import 'package:flutter/material.dart';

import '../../../../widgets/widget_constant.dart';

class CustomColor {
  final String name;
  final String code;

  CustomColor({required this.name, required this.code,});

  Widget get widget => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Color(int.parse(code)),
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
  CustomColor( name: '빨강', code: '0xFFAF092A'),
  CustomColor( name: '주황', code: '0xFFD3771B'),
  CustomColor( name: '초록', code: '0xFF35B907'),
  CustomColor( name: '파랑', code: '0xFF0765C4'),
  CustomColor( name: '보라', code: '0xFFA606AB'),
];
