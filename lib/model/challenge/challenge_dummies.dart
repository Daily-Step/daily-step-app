import '../category/category_model.dart';
import '../record/record_model.dart';
import 'challenge_model.dart';

final List<ChallengeModel> dummyChallenges = [
  ChallengeModel(
    id: 1,
    category: CategoryModel(
      id: 1,
      name: "Fitness",
    ),
    record: RecordModel(
      successDates: [
        DateTime(2024, 12, 10),
        DateTime(2024, 12, 3),
        DateTime(2024, 11, 25),
        DateTime(2024, 11, 28),
      ],
    ),
    title: "30-Day Fitness Challenge",
    content: "30-Day Fitness Challenge",
    durationInWeeks: 4,
    weekGoalCount: 5,
    totalGoalCount: 20,
    color: '0xFF2257FF',
    startDatetime: DateTime(2024, 11, 30), // 시작 날짜
    endDatetime: DateTime(2024, 12, 30), // 종료 날짜
  ),
  ChallengeModel(
    id: 2,
    category: CategoryModel(
      id: 2,
      name: "Diet",
    ),
    record: RecordModel(
      successDates: [
        DateTime(2024, 12, 11),
        DateTime(2024, 12, 4),
        DateTime(2024, 11, 26),
        DateTime(2024, 11, 25),
        DateTime(2024, 11, 28),
      ],
    ),
    title: "Healthy Eating Challenge",
    content: "30-Day Fitness Challenge",
    durationInWeeks: 3,
    weekGoalCount: 4,
    totalGoalCount: 16,
    color: '0xFFFF3B30',
    startDatetime: DateTime(2024, 11, 25), // 시작 날짜
    endDatetime: DateTime(2024, 12, 18), // 종료 날짜
  ),
  ChallengeModel(
    id: 3,
    category: CategoryModel(
      id: 3,
      name: "Reading",
    ),
    record: RecordModel(
      successDates: [
        DateTime(2024, 12, 9),
        DateTime(2024, 12, 2),
        DateTime(2024, 11, 25),
        DateTime(2024, 11, 28),
      ],
    ),
    title: "Weekly Reading Challenge",
    content: "30-Day Fitness Challenge",
    durationInWeeks: 2,
    weekGoalCount: 3,
    totalGoalCount: 12,
    color: '0xFF30B0C7',
    startDatetime: DateTime(2024, 12, 2), // 시작 날짜
    endDatetime: DateTime(2024, 12, 20), // 종료 날짜
  ),
];
