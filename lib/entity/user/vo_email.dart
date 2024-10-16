import 'package:freezed_annotation/freezed_annotation.dart';
part 'vo_email.freezed.dart';

@freezed
class Email with _$Email {
  const factory Email({
    required final int socialType,
    required final String socialEmail,
  }) = _Email;
}