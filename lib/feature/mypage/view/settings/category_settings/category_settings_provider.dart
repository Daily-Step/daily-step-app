// mypage/viewmodel/category_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category {
  final String id;
  final String name;
  final String emoji;

  Category({required this.id, required this.name, required this.emoji});
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  CategoryNotifier() : super([]);

  // 선택할 수 있는 카테고리 목록을 반환하는 getter
  List<Category> get availableCategories {
    return [
      Category(id: '1', name: '운동', emoji: '🏃‍♂️'),
      Category(id: '2', name: '식단', emoji: '🥗'),
      Category(id: '3', name: '공부', emoji: '📚'),
      Category(id: '4', name: '게임', emoji: '🎮'),
      Category(id: '5', name: '여행', emoji: '✈️'),
      Category(id: '6', name: '독서', emoji: '📖'),
      Category(id: '7', name: '예술', emoji: '🎨'),
      Category(id: '8', name: '영화', emoji: '🎬'),
      Category(id: '9', name: '음악', emoji: '🎵'),
      Category(id: '10', name: '쇼핑', emoji: '🛍️'),
    ];
  }

  void addCategory(Category category) {
    // 이미 선택된 카테고리인지 확인하여 중복 방지
    if (!state.any((existingCategory) => existingCategory.id == category.id)) {
      state = [...state, category]; // 카테고리 추가
    }
  }

  void setSelectedCategories(List<Category> categories) {
    state = categories; // 선택된 카테고리를 상태로 설정
  }

  void removeCategory(String id) {
    state = state.where((category) => category.id != id).toList();
  }

  void loadInitialCategories() {
    // 초기 카테고리 로드
    // 위의 availableCategories를 사용하도록 변경할 수 있습니다.
  }
}
