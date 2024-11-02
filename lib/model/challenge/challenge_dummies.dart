import 'challenge_model.dart';

var dummyChallenges = [
  ChallengeModel(
    id: 1,
    memberId: 101,
    categoryId: 5,
    title: '일일 운동 챌린지',
    content: '건강 유지를 위해 매일 운동 루틴을 완수하세요.',
    color: '#FF5733',
    weeklyGoalCount: 5, // 7보다 작음
    totalGoalCount: 28, // 7의 배수
    achievedTotalGoalCount: 20, // totalGoalCount보다 작음
    startDatetime: DateTime(2024, 1, 1),
    endDatetime: DateTime(2024, 1, 28),
    createdAt: DateTime(2023, 12, 15),
    updatedAt: DateTime(2024, 1, 10),
  ),
  ChallengeModel(
    id: 2,
    memberId: 101,
    categoryId: 3,
    title: '주간 독서',
    content: '정신적 성장을 위해 매주 한 권의 책을 완독하세요.',
    color: '#4287f5',
    weeklyGoalCount: 1, // 7보다 작음
    totalGoalCount: 7,  // 7의 배수
    achievedTotalGoalCount: 3, // totalGoalCount보다 작음
    startDatetime: DateTime(2024, 2, 1),
    endDatetime: DateTime(2024, 2, 28),
    createdAt: DateTime(2024, 1, 25),
    updatedAt: DateTime(2024, 2, 5),
  ),
  ChallengeModel(
    id: 3,
    memberId: 101,
    categoryId: 2,
    title: '매일 기타 연습',
    content: '매일 최소 20분 동안 기타를 연습하여 실력을 향상시키세요.',
    color: '#34a853',
    weeklyGoalCount: 6, // 7보다 작음
    totalGoalCount: 42, // 7의 배수
    achievedTotalGoalCount: 30, // totalGoalCount보다 작음
    startDatetime: DateTime(2024, 3, 1),
    endDatetime: DateTime(2024, 4, 12),
    createdAt: DateTime(2024, 2, 20),
    updatedAt: DateTime(2024, 3, 10),
  ),
];