import 'dart:ui';
import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5;
    double dashSpace = 5;
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final radius = Radius.circular(20);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      radius,
    );

    // 전체 경로를 저장할 Path
    Path dashedPath = Path();

    // RRect의 전체 경로를 가져옴
    Path rrectPath = Path()..addRRect(rrect);

    // PathMetrics를 사용하여 경로를 따라 점선을 그림
    PathMetrics pathMetrics = rrectPath.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0;
      bool draw = true;
      while (distance < pathMetric.length) {
        if (draw) {
          Path extractPath = pathMetric.extractPath(
            distance,
            distance + dashWidth,
          );
          dashedPath.addPath(extractPath, Offset.zero);
        }
        distance += draw ? dashWidth : dashSpace;
        draw = !draw;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}