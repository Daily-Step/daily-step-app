import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WSelectInput extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String? label;
  final bool hasError;
  final String? errorMessage;

  const WSelectInput({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(label != null)
          Text(
            label!,
            style: labelTextStyle,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: hasError ? Colors.red : Colors.grey.shade300,
                ),
                borderRadius: globalBorderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: child,
              ),
            ),
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
      ),
    );
  }
}