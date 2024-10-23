import 'package:flutter/material.dart';

class WProgressIndicator extends StatelessWidget {
  final int percentage;

  const WProgressIndicator({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Positioned.fill(
            left: 7,
            top: 10,
            child: Text(
              '${percentage.toInt()}%',
              style: const TextStyle(fontSize: 12),
            )
            ,
          ),
        ],
      ),
    );
  }
}