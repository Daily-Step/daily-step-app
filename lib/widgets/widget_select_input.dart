import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WSelectInputWithLabel extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String? label;
  final bool hasError;
  final String? errorMessage;
  final bool disabled;

  const WSelectInputWithLabel({
    Key? key,
    required this.child,
    required this.onTap,
    this.label,
    this.hasError = false,
    this.errorMessage,
    this.disabled = false,
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
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: disabled ? Colors.grey : Colors.black),
              ),
            Spacer(),
            Column(
              children: [
                WSelectInput(
                  child: child,
                  onTap: onTap,
                  hasError: hasError,
                  width: 180,
                  disabled: disabled,
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
  final bool disabled;

  const WSelectInput({
    required this.child,
    required this.onTap,
    this.hasError = false,
    this.width = double.infinity,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
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
                  color: disabled ? disabledColor : subTextColor,
                )
              ],
            )),
      ),
    );
  }
}
