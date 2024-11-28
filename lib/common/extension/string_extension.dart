extension StringExtension on String {
  DateTime get toDateTime => DateTime.parse(this);
  /// 한글, 영어, 숫자만으로 작성된 문자열만 true 반환
  bool nickNameValidation() {
    final RegExp specialCharRegExp = RegExp(r'^[ㄱ-ㅎ가-힣a-zA-Z0-9]+$');
    return specialCharRegExp.hasMatch(this);
  }
}