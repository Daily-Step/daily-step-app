import 'package:dailystep/model/category/category_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../model/category/category_dummies.dart';
import '../action/category_list_action.dart';

part 'category_viewmodel.g.dart';

@riverpod
class CategoryViewModel extends _$CategoryViewModel {
  late final List<CategoryModel> _initialTasks;

  CategoryState build() {
    _initialTasks = dummyCategories;
    return CategoryState(
      categoryList: _initialTasks,
      selectedCategory: null,
    );
  }

  void handleAction(CategoryListAction action) {
    if (action is FindItemAction) {
      _handleFindItem(action);
    }
  }

  void _handleFindItem(FindItemAction action) {
    final categoryList = state.categoryList;
    try {
      final selectedCategory = categoryList.firstWhere((category) => category.id == action.id);
      state = state.copyWith(selectedCategory: selectedCategory);
    } catch (e) {
      print('Category with id ${action.id} not found');
    }
  }
}

class CategoryState {
  final List<CategoryModel> categoryList;
  final CategoryModel? selectedCategory;

  const CategoryState({
    required this.categoryList,
    this.selectedCategory,
  });

  CategoryState copyWith({
    List<CategoryModel>? categoryList,
    CategoryModel? selectedCategory,
  }) {
    return CategoryState(
      categoryList: categoryList ?? this.categoryList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
