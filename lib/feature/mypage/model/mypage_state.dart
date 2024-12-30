// lib/model/mypage_state.dart
import 'package:dailystep/feature/mypage/model/mypage_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mypage_state.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  const factory MyPageState.initial() = MyPageStateInitial;
  const factory MyPageState.loading() = MyPageStateLoading;
  const factory MyPageState.loaded({required MyPageModel user}) = MyPageStateLoaded;
  const factory MyPageState.error({required String message}) = MyPageStateError;
}