import 'package:dailystep/common/util/size_util.dart';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';

class WCard extends StatelessWidget {
  final Widget child;
  final double? padding;

  const WCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0 * su, right: 8.0 * su),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: globalBorderRadius,
        ),
        elevation: 1,
        shadowColor: Color(0xD5E7E7E7),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 16.0),
          child: child,
        ),
      ),
    );
  }
}
