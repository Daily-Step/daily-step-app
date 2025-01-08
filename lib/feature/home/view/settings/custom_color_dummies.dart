import 'package:flutter/material.dart';

import '../../../../widgets/widget_constant.dart';

class CustomColor {
  final int id;
  final String name;
  final String code;

  CustomColor({
    required this.id,
    required this.name,
    required this.code,
  });

  Widget getWidget(int selectedIndex, int index) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        style: TextStyle(
          fontSize: pickerFontSize,
          color: selectedIndex == index ? Colors.black : Colors.grey,
        ),
      )
    ]);
  }
Widget get widget => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 20,
        height: 20,
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
  CustomColor(id: 0, name: '빨강', code: '0xFFFF3B30'),
  CustomColor(id: 1, name: '주황', code: '0xFFFF9500'),
  CustomColor(id: 2, name: '하늘', code: '0xFF30B0C7'),
  CustomColor(id: 3, name: '파랑', code: '0xFF2257FF'),
  CustomColor(id: 4, name: '보라', code: '0xFF8120FF'),
];
