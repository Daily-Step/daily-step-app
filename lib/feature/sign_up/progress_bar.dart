import 'package:flutter/material.dart';

class ProgressStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps = 6;
  final List<String> stepLabels = ['닉네임', '생일', '성별', '직무', '연차'];

  ProgressStepper({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: List.generate(totalSteps, (index) {
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomPaint(
                        size: Size(double.infinity, 2),
                        painter: DashedLinePainter(
                          isDashed: index >= currentStep,
                          color: index < currentStep ? Colors.black : Colors.grey[300]!,
                        ),
                      ),
                    ),
                    if (index < totalSteps - 1)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < currentStep ? Colors.black : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              stepLabels.length,
                  (index) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    stepLabels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: index < currentStep ? Colors.black : Colors.grey[500],
                      fontWeight: index == currentStep ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if(index == 4)
                  SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final bool isDashed;
  final Color color;

  DashedLinePainter({required this.isDashed, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    if (isDashed) {
      final dashWidth = 5.0;
      final dashSpace = 3.0;
      double startX = 0;

      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, 0),
          Offset(startX + dashWidth, 0),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    } else {
      canvas.drawLine(
        Offset(0, 0),
        Offset(size.width, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
