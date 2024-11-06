import 'package:flutter/cupertino.dart';

class CustomColor {
  final Color color;
  final String name;

  CustomColor({required this.color, required this.name});

  Widget get widget => Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}