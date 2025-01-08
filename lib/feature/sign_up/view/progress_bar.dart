import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/util/size_util.dart';

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
                        size: Size(double.infinity, 13 * su),
                        painter: DashedLinePainter(
                          isDashed: index >= currentStep,
                          color: index < currentStep ? Colors.black : Colors.grey[300]!,
                        ),
                      ),
                    ),
                    if (index < totalSteps - 1)
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: index <= currentStep - 1 ? Colors.black : Colors.grey[300]!,
                                    width: 1,
                                  ),
                                  color: index == currentStep - 1
                                      ? Colors.black
                                      : Colors.transparent,
                                ),
                                child: index < currentStep - 1
                                    ? Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/check.svg',
                                    width: 12,
                                    height: 12,
                                    color: Colors.black,
                                  ),
                                )
                                    : null,
                              ),
                            ],
                          ),
                          if (index < stepLabels.length)
                            Text(
                              stepLabels[index],
                              style: TextStyle(
                                fontSize: 11 * su,
                                color: index <= currentStep - 1 ? Colors.black : Colors.grey[500],
                                fontWeight: index == currentStep - 1 ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              );
            }),
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
      final dashWidth = 5.0 * su;
      final dashSpace = 3.0 * su;
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