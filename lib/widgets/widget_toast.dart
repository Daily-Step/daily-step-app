import 'package:dailystep/widgets/widget_constant.dart';
import 'package:flutter/material.dart';
import '../config/app.dart';

///TODO: 토스트 메세지 위치 수정
class WToast {
  static void show(
      String message, {
        String subMessage = '',
        Duration duration = const Duration(seconds: 2),
        double? top
      }) {
    SnackBar snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 80, left: 16, right: 16),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: _ToastWidget(
                message: message,
                subMessage: subMessage,
                duration: duration,
              ));
    scaffoldMessengerStateKey.currentState?.clearSnackBars();
    scaffoldMessengerStateKey.currentState?.showSnackBar(snackBar);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final String subMessage;
  final Duration duration;

  const _ToastWidget({
    Key? key,
    required this.message,
    required this.subMessage,
    required this.duration,
  }) : super(key: key);

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          width10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
              widget.subMessage,
              textAlign: TextAlign.center,
              style: subTextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
