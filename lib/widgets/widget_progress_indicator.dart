import 'package:flutter/material.dart';

class WProgressIndicator extends StatelessWidget {
  final int percentage;
  final double fontSize;
  final double width;
  final double height;
  final double strokeWidth;
  final Color color;
  final String? subString;

  const WProgressIndicator({
    super.key,
    required this.percentage,
    required this.width,
    required this.height,
    required this.strokeWidth,
    required this.fontSize,
    required this.color,
    this.subString,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        height: width,
        width: height,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          value: percentage / 100,
          strokeWidth: strokeWidth,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
      RichText(
        text: TextSpan(
          text: '${percentage.toInt()}',
          style: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
          children:[TextSpan(
            text: '${subString ?? ''}',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color)
          )]
        ),
      ),
    ]);
  }
}
