class Category {
  final int id;
  final String name;
  final String emoji;

  Category({required this.id, required this.name, required this.emoji});

  @override
  String toString() {
    return '${name} ${emoji}';
  }
}

final List<Category> dummyCategories = [
  Category(id: 0, name: '운동', emoji: '🏃'),
  Category(id: 1, name: '식단', emoji: '🥗'),
  Category(id: 2, name: '공부', emoji: '📚'),
  Category(id: 3, name: '게임', emoji: '🎮'),
  Category(id: 4, name: '여행', emoji: '✈️'),
  Category(id: 5, name: '독서', emoji: '📖'),
  Category(id: 6, name: '예술', emoji: '🎨'),
  Category(id: 7, name: '영화', emoji: '🎬'),
  Category(id: 8, name: '음악', emoji: '🎵'),
  Category(id: 9, name: '쇼핑', emoji: '🛍️'),
];