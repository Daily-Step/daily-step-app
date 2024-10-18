import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'config/app.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'your_native_app_key_here');
  runApp(ProviderScope(child: const App()));
}
