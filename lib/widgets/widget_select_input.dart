import 'package:flutter/material.dart';

class WSelectInput extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String title;

  const WSelectInput({
    Key? key,
    required this.child,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black54)
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}