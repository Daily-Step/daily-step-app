import 'challenge_model.dart';

var dummyChallenges = [
  ChallengeModel(
    id: 1,
    memberId: 101,
    categoryId: 5,
    title: '일일 운동 챌린지',
    content: '건강 유지를 위해 매일 운동 루틴을 완수하세요.',
    colorId: 2,
    weeklyGoalCount: 5,
    // 7보다 작음
    totalGoalCount: 28,
    // 7의 배수
    // totalGoalCount보다 작음
    startDatetime: DateTime(2024, 11, 20),
    endDatetime: DateTime(2024, 12, 28),
    createdAt: DateTime(2023, 11, 1),
    updatedAt: DateTime(2024, 1, 10),
      successList: [
        DateTime(2024, 11, 10),
        DateTime(2024, 11, 11),
        DateTime(2024, 11, 12),
        DateTime(2024, 11, 13),
        DateTime(2024, 11, 14),
        DateTime(2024, 11, 15),
        DateTime(2024, 11, 16),
        DateTime(2024, 11, 17),
        DateTime(2024, 11, 18),
        DateTime(2024, 11, 19),
        DateTime(2024, 11, 24)
      ]

  ),
  ChallengeModel(
    id: 2,
    memberId: 101,
    categoryId: 3,
    title: '주간 독서',
    content: '정신적 성장을 위해 매주 한 권의 책을 완독하세요.',
    colorId: 3,
    weeklyGoalCount: 1,
    // 7보다 작음
    totalGoalCount: 7,
    // 7의 배수
    // totalGoalCount보다 작음
    startDatetime: DateTime(2024, 11, 20),
    endDatetime: DateTime(2024, 12, 28),
    createdAt: DateTime(2024, 1, 25),
    updatedAt: DateTime(2024, 2, 5),
    successList: [
      DateTime(2024, 11, 22),
      DateTime(2024, 11, 17),
      DateTime(2024, 11, 18),
      DateTime(2024, 11, 19),
      DateTime(2024, 11, 24)
    ],
  ),
  ChallengeModel(
    id: 3,
    memberId: 101,
    categoryId: 2,
    title: '매일 기타 연습',
    content: '매일 최소 20분 동안 기타를 연습하여 실력을 향상시키세요.',
    colorId: 4,
    weeklyGoalCount: 6,
    // 7보다 작음
    totalGoalCount: 42,
    // 7의 배수
    // totalGoalCount보다 작음
    startDatetime: DateTime(2024, 11, 20),
    endDatetime: DateTime(2024, 12, 28),
    createdAt: DateTime(2024, 2, 20),
    updatedAt: DateTime(2024, 3, 10),
    successList: [
      DateTime(2024, 11, 22),
      DateTime(2024, 11, 10),
      DateTime(2024, 11, 11),
      DateTime(2024, 11, 12),
      DateTime(2024, 11, 13),
      DateTime(2024, 11, 14),
      DateTime(2024, 11, 17),
      DateTime(2024, 11, 24),
      DateTime(2024, 11, 25),
    ],
  ),
];

var dummySuccessList = [
  DateTime(2024, 11, 22),
  DateTime(2024, 11, 25),
  DateTime(2024, 11, 28),
  DateTime(2024, 11, 29),
  DateTime(2024, 11, 30),
  DateTime(2024, 12, 1),
  DateTime(2024, 12, 2),
];
