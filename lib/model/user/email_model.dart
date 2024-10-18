import 'package:freezed_annotation/freezed_annotation.dart';
part 'email_model.freezed.dart';

@freezed
class Email with _$Email {
  const factory Email({
    required final int socialType,
    required final String socialEmail,
  }) = _Email;
}