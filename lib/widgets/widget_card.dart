import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WCard extends StatelessWidget {
  final Widget child;

  const WCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: globalBorderRadius,
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
