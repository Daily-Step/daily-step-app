import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WSelectInputWithLabel extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String? label;
  final bool hasError;
  final String? errorMessage;

  const WSelectInputWithLabel({
    Key? key,
    required this.child,
    required this.onTap,
    this.label,
    this.hasError = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalMargin,
      child: Column(children: [
        Row(
          children: [
            if (label != null)
              Text(
                label!,
                style: labelTextStyle,
              ),
            Spacer(),
            Column(
              children: [
                WSelectInput(
                  child: child,
                  onTap: onTap,
                  hasError: hasError,
                  width: 150,
                ),
                if (hasError && errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}

class WSelectInput extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool hasError;
  final double width;

  const WSelectInput({
    required this.child,
    required this.onTap,
    this.hasError = false,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
            border: Border.all(
              color: hasError ? Colors.red : Colors.grey.shade300,
            ),
            borderRadius: globalBorderRadius,
            color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                child,
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: subTextColor,
                )
              ],
            )),
      ),
    );
  }
}
