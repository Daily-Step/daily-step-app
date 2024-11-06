// mypage/view/settings/category_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../category_settings/category_settings_provider.dart';

class CategorySettingsScreen extends ConsumerWidget {
  const CategorySettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 선택된 카테고리 리스트를 저장할 변수
    final selectedCategories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("카테고리 설정")),
      body: Center(
        child: Column(
          children: [
            // 선택된 카테고리를 상단에 표시
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: selectedCategories.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      // GridView의 크기를 자식 위젯의 크기에 맞춤
                      physics: const NeverScrollableScrollPhysics(),
                      // 스크롤을 비활성화
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 두 개의 열로 설정
                        childAspectRatio: 2, // 각 아이템의 비율
                        mainAxisSpacing: 8.0, // 세로 간격
                        crossAxisSpacing: 8.0, // 가로 간격
                      ),
                      itemCount: selectedCategories.length,
                      itemBuilder: (context, index) {
                        final category = selectedCategories[index];
                        return Chip(
                          labelPadding: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
                          label: Text(
                            '${category.emoji} ${category.name}',
                            style: const TextStyle(fontSize: 18), // 텍스트 크기 키움
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          // 라벨 패딩 조정
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // 둥근 모서리 조정
                          ),
                          elevation: 2, // 그림자 효과 추가
                        );
                      },
                    )
                  : const Text(
                      '선택된 카테고리가 없습니다.',
                      style: TextStyle(fontSize: 18),
                    ),
            ),
            const SizedBox(height: 20),
            // ElevatedButton은 선택된 카테고리 여부와 상관없이 항상 표시됨
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 카테고리 목록을 모달로 로드
                _showCategoryDialog(context, ref);
              },
              child: const Icon(Icons.add), // 아이콘으로 변경
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context, WidgetRef ref) {
    final selectedCategoriesInDialog = ValueNotifier<List<Category>>([]); // ValueNotifier 사용

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final availableCategories = ref.read(categoryProvider.notifier).availableCategories;

        return AlertDialog(
          title: const Text("카테고리 목록"),
          content: Container(
            width: double.maxFinite, // 다이얼로그 폭을 설정
            constraints: BoxConstraints(maxHeight: 400), // 최대 높이 설정
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder<List<Category>>(
                    valueListenable: selectedCategoriesInDialog,
                    builder: (context, selectedCategories, _) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 두 개의 열로 설정
                          childAspectRatio: 2, // 각 아이템의 비율
                        ),
                        itemCount: availableCategories.length,
                        itemBuilder: (context, index) {
                          final category = availableCategories[index];

                          // 선택된 카테고리인지 확인
                          final isSelected = selectedCategories.contains(category);

                          return GestureDetector(
                            onTap: () {
                              // 카테고리 선택/선택 해제
                              if (isSelected) {
                                selectedCategoriesInDialog.value = List.from(selectedCategories)..remove(category); // 선택 해제
                              } else {
                                selectedCategoriesInDialog.value = List.from(selectedCategories)..add(category); // 선택
                              }
                            },
                            child: Card(
                              color: isSelected ? Colors.grey.shade300 : Colors.white, // 선택 시 밝은 회색으로 변경
                              elevation: isSelected ? 4 : 2, // 선택 시 그림자 효과 추가
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('${category.emoji} ${category.name}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // 선택된 카테고리를 다이얼로그 하단에 표시
                if (selectedCategoriesInDialog.value.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text('선택한 카테고리:'),
                  Wrap(
                    spacing: 8.0,
                    children: selectedCategoriesInDialog.value.map((category) {
                      return Chip(
                        label: Text('${category.emoji} ${category.name}'),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 선택한 카테고리를 저장하고 중복 제거
                ref.read(categoryProvider.notifier).setSelectedCategories(selectedCategoriesInDialog.value.toSet().toList());
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text("확인"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text("닫기"),
            ),
          ],
        );
      },
    );
  }
}
