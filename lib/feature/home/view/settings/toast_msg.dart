class ToastMsg {
  final int id;
  final int type;// 0: 회원가입 후 첫 달성, 1: 하루 첫 달성, 2: 일반 달성
  final String title;
  final String content;

  ToastMsg({required this.id, required this.type, required this.title,required this.content,});
}

List<ToastMsg> toastMsg = [
  ToastMsg( id: 0, type: 0, title: '첫 스타트를 끊었습니다! 🔫',content:'챌린지를 처음 달성했습니다'),
  ToastMsg( id: 1, type: 0, title: '첫 시작, 정말 멋져요! 🎊',content:'챌린지를 처음 달성했습니다'),
  ToastMsg( id: 2, type: 1, title: '시작이 반이에요! 👍',content:'챌린지를 달성했습니다'),
  ToastMsg( id: 3, type: 2, title: '한 계단 상승 🥰',content:'챌린지를 달성했습니다'),
  ToastMsg( id: 4, type: 2, title: '오늘도 멋진 하루~ 🌈',content:'챌린지를 달성했습니다'),
  ToastMsg( id: 5, type: 2, title: '와우, 성공적인 한 걸음! 🚶',content:'챌린지를 달성했습니다'),
  ToastMsg( id: 6, type: 2, title: '와, 당신은 킹왕짱! 👑',content:'챌린지를 달성했습니다'),
  ToastMsg( id: 7, type: 2, title: '멋짐이 +1 상승했어요 😎',content:'챌린지를 달성했습니다'),
];