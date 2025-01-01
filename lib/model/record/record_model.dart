import 'package:freezed_annotation/freezed_annotation.dart';
part 'record_model.freezed.dart';
part 'record_model.g.dart';

@freezed
class RecordModel with _$RecordModel {
  const factory RecordModel({
    required final List<String> successDates,
  }) = _Record;

  factory RecordModel.fromJson(Map<String, dynamic> json) =>
      _$RecordModelFromJson(json);
}