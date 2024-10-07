import 'package:flutter/material.dart';

class WTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const WTextField(
      this.controller, {
        Key? key, required this.hintText,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ))),
      ),
    );
  }
}