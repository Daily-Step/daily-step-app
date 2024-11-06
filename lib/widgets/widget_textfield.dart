import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final int? maxCharacters;
  final String? counterText;
  final String? label;
  final bool hasError;
  final String? errorMessage;

  WTextField(
      this.controller, {
        Key? key,
        required this.hintText,
        required this.onChanged,
        this.maxCharacters,
        this.counterText,
        this.label,
        this.hasError = false,
        this.errorMessage,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(label!, style: labelTextStyle),
          if (label != null)
            const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLength: maxCharacters ?? 10,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey.shade300,
                ),
                borderRadius: globalBorderRadius,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey.shade300,
                ),
                borderRadius: globalBorderRadius,
              ),
              hintText: hintText,
              hintStyle: hintTextStyle,
              counterText: counterText ?? '',
              errorText: hasError ? errorMessage : null,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}