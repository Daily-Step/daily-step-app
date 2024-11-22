import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final int? maxCharacters;
  final int? maxLines;
  final String? counterText;
  final String? label;
  final bool hasError;
  final String? errorMessage;
  final Widget? suffixButton;

  const WTextField(
      this.controller, {
        Key? key,
        required this.hintText,
        required this.onChanged,
        this.maxCharacters,
        this.maxLines,
        this.counterText,
        this.label,
        this.hasError = false,
        this.errorMessage,
        this.suffixButton, // 추가된 파라미터
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
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey.shade300,
                ),
                borderRadius: globalBorderRadius,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey.shade500,
                ),
                borderRadius: globalBorderRadius,
              ),
              hintText: hintText,
              hintStyle: hintTextStyle,
              counterText: counterText ?? '',
              errorText: hasError ? errorMessage : null,
              suffixIcon: suffixButton != null
                  ? Padding(
                padding: const EdgeInsets.only(right:4,bottom: 6),
                child: suffixButton,
              )
                  : null,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
