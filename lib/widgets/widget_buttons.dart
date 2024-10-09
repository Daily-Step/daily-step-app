import 'package:flutter/material.dart';

class WCtaFloatingButton extends StatelessWidget {
  final String text;

  const WCtaFloatingButton(
      this.text, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Column(
        children: [
          WCtaButton(text, onPressed: () {  },),
        ],
      ),
    );
  }
}

class WCtaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const WCtaButton(
      this.text, {
        Key? key, required this.onPressed,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          minimumSize: const Size(200, 50),
        ),
        child: Text(text),
      ),
    );
  }
}