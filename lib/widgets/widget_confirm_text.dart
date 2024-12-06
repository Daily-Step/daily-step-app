import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WConfirmButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final bool isValidProvider;  // Change from StateProvider<bool> to bool

  const WConfirmButton({
    super.key,
    required this.onPressed,
    required this.isValidProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: isValidProvider ? onPressed : null,
      child: Text(
        '확인',
        style: TextStyle(
          color: isValidProvider ? Color(0xff717171) : Color(0xffC6C6C6),
          fontSize: 25
        ),
      ),
    );
  }
}