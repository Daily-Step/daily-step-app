import 'package:flutter/material.dart';
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

List<CustomColor> customColors = [
  CustomColor(color: Colors.blue, name: 'Blue'),
  CustomColor(color: Colors.lightGreen, name: 'Light Green'),
  CustomColor(color: Colors.teal, name: 'Teal'),
  CustomColor(color: Colors.pinkAccent, name: 'Pink Accent'),
  CustomColor(color: Colors.purple, name: 'Purple'),
  CustomColor(color: Colors.orange, name: 'Orange'),
];