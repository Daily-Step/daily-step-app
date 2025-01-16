import 'dart:math';

class ToastMsg {
  final int id;
  final int type; // 0: 회원가입 후 첫 달성, 1: 하루 첫 달성, 2: 일반 달성, 3: 챌린지 생성
  final String title;
  final String content;

  ToastMsg({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
  });

  factory ToastMsg.create(int type) {
    if (type == 1) {
      // 하루 첫 달성 메시지
      return toastMsg.firstWhere((el) => el.type == 1);
    } else if (type == 2) {
      // 일반 달성 메시지 (랜덤 선택)
      int randomId = Random().nextInt(5) + 3; // IDs between 3 and 7
      return toastMsg.firstWhere((el) => el.id == randomId);
    } else if (type == 3) {
      // 챌린지 생성 메시지 (랜덤 선택)
      int randomId = Random().nextInt(2) + 8; // IDs between 8 and 9
      return toastMsg.firstWhere((el) => el.id == randomId);
    } else if (type == 0) {
      // 기본 메시지 (회원가입 후 첫 달성, 랜덤 선택)
      int randomId = Random().nextInt(2); // IDs between 0 and 1
      return toastMsg.firstWhere((el) => el.id == randomId);
    } else {
     // 오류 메세지
      return toastMsg.firstWhere((el) => el.type == type);
    }
  }
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
  ToastMsg( id: 8, type: 3, title: '야호! 새 챌린지를 등록했어요',content:'새 챌린지를 등록했습니다'),
  ToastMsg( id: 9, type: 3, title: '큰 결심 했네요! 응원합니다!',content:'새 챌린지를 등록했습니다'),
  ToastMsg( id: 10, type: 4, title: '시스템 오류가 발생했습니다',content:'잠시후 다시 시도해주세요'),
  ToastMsg( id: 11, type: 5, title: '현재 접속이 원활하지 않아요',content:'네트워크 연결을 확인해주세요'),
];