enum SocialType {
  kakao('카카오', 0),
  naver('네이버', 1),
  google('구글', 2);

  final String name;
  final int code;

  const SocialType(this.name, this.code,);
}