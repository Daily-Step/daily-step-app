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
  final bool isEnable;
  final String? errorMessage;
  final Widget? suffixButton;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool isBox;

  const WTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.maxCharacters,
    this.maxLines,
    this.counterText,
    this.label,
    this.isEnable = true,
    this.errorMessage,
    this.suffixButton,
    this.isBox = false,
    this.hintStyle,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newBorderColor = isEnable ? borderColor : Colors.red;

    return Padding(
      padding: globalMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) Text(label!, style: labelTextStyle),
          if (label != null) const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLength: maxCharacters ?? 10,
            maxLines: maxLines ?? 1,
            style: textStyle,
            decoration: InputDecoration(
              border: isBox
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: newBorderColor),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : null,
              fillColor: isBox ? Colors.white : null,
              // 배경색
              filled: isBox,
              // 배경색 활성화
              enabledBorder: isBox
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: newBorderColor),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: newBorderColor,
                      ),
                    ),
              focusedBorder: isBox
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: newBorderColor),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: newBorderColor,
                      ),
                    ),
              hintText: hintText,
              hintStyle: hintStyle,
              counterText: counterText ?? '',
              errorText: isEnable ? null : errorMessage,
              suffixIcon: suffixButton != null
                  ? Padding(
                      padding: const EdgeInsets.all(10),
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
