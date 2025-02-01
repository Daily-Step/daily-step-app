import 'dart:async';
import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/util/size_util.dart';

class WToast {
  static void show(BuildContext context,
      String message, {
        String subMessage = '',
        Duration duration = const Duration(seconds: 2),
        double offsetY = 42.0, // 기본 Y축 위치
        Icon? icon,
      }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) =>
          _ToastWidget(
            message: message,
            subMessage: subMessage,
            duration: duration,
            offsetY: offsetY,
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration + const Duration(milliseconds: 500), () {
      overlayEntry.remove();
    });
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final String subMessage;
  final Duration duration;
  final double offsetY;
  final Icon? icon;

  const _ToastWidget({
    Key? key,
    required this.message,
    required this.subMessage,
    required this.duration,
    required this.offsetY,
    this.icon,
  }) : super(key: key);

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Timer(widget.duration, () => _controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.offsetY,
      left: MediaQuery
          .of(context)
          .size
          .width * 0.027,
      right: MediaQuery
          .of(context)
          .size
          .width * 0.027,
      child: FadeTransition(
        opacity: _opacity,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                widget.icon ?? Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xff008A1E),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/check.svg',
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 22.5,
                      height: 22.5,
                    ),
                  ),
                ),
                width10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,
                          fontSize: 17.0 * su,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.subMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13 * su ,color: Colors.grey.shade500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
