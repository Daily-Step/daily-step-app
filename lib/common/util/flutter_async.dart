import 'dart:async';
import 'package:flutter/material.dart';

extension AsyncExt on Object {
  Timer delay(Function func, [Duration duration = const Duration(milliseconds: 50)]) {
    return Timer(duration, () {
      if (this is State && !(this as State).mounted) {
        return;
      }
      func();
    });
  }
}