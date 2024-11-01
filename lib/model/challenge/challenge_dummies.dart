import 'challenge_model.dart';

var dummyChallenges = [
  ChallengeModel(
    id: 1,
    memberId: 101,
    categoryId: 5,
    title: 'Daily Exercise Challenge',
    content: 'Complete a daily exercise routine to stay healthy.',
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
    title: 'Read a Book Weekly',
    content: 'Finish one book every week for mental growth.',
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
    title: 'Practice Guitar Daily',
    content: 'Improve skills by practicing guitar for at least 20 minutes every day.',
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
