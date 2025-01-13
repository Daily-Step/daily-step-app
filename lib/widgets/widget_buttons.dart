import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

import '../common/util/size_util.dart';

class WRoundButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;

  const WRoundButton({
    required this.isEnabled,
    required this.onPressed,
    required this.text,
    this.textStyle,
  });

  Widget build(BuildContext context) {
    return Container(
      height: 18 * su,
      width: 93 * su,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000 * su),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(1000 * su),
        onTap: isEnabled ? onPressed : null,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * su),
            child: Text(
              text,
              style: textStyle
            ),
          ),
        ),
      ),
    );
  }
}

class WCtaFloatingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LinearGradient? gradient;

  const WCtaFloatingButton(
    this.text, {
    Key? key,
    required this.onPressed,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Column(
        children: [
          WCtaButton(
            text,
            onPressed: onPressed,
            gradient: gradient,
          ),
        ],
      ),
    );
  }
}

class WCtaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LinearGradient? gradient;

  const WCtaButton(
    this.text, {
    Key? key,
    required this.onPressed,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return Container(
      decoration: BoxDecoration(borderRadius: globalBorderRadius),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: isEnabled ? Colors.white : Colors.grey[400],
          padding: EdgeInsets.zero, // 패딩을 0으로 설정하여 그라데이션이 버튼 전체를 채우도록
          minimumSize: const Size(200, 50),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: globalBorderRadius,
            gradient: gradient != null && isEnabled ? gradient : null,
            color: gradient != null ? null : (isEnabled ? Colors.black : Colors.grey[200]),
          ),
          child: Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
