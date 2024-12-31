import 'package:dailystep/data/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/secure_storage/secure_storage_service.dart';
import '../action/mypage_action.dart';
import '../model/mypage_model.dart';
import '../model/mypage_state.dart';

class MyPageViewModel extends StateNotifier<MyPageState> {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;

  MyPageViewModel(this._apiClient, this._secureStorageService)
      : super(MyPageState.initial());

  @override
  void handleEvent(MyPageAction event) {
    if (event is FetchUserDataAction) {
      fetchUserData();
    } else if (event is UpdateUserProfileAction) {
      updateUserProfile(event);
    }
  }

  Future<void> fetchUserData() async {
    state = MyPageState.loading();
    try {
      final token = await _secureStorageService.getAccessToken();
      if (token == null) {
        throw Exception('액세스 토큰이 없습니다.');
      }

      final response = await _apiClient.get(
        'member',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final userData = MyPageModel.fromJson(response.data);
        state = MyPageState.loaded(user: userData);
      } else {
        state = MyPageState.error(message: '데이터 가져오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      state = MyPageState.error(message: '데이터 가져오는 중 오류 발생: $e');
    }
  }

  Future<void> updateUserProfile(UpdateUserProfileAction action) async {
    state = MyPageState.loading();
    try {
      final token = await _secureStorageService.getAccessToken();
      if (token == null) {
        throw Exception('액세스 토큰이 없습니다.');
      }

      final response = await _apiClient.put(
        'member',
        data: {
          'nickname': action.newUserName,
          'birth': action.birth.toIso8601String(),
          'gender': action.gender,
        },
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final updatedUser = MyPageModel.fromJson(response.data);
        state = MyPageState.loaded(user: updatedUser);
      } else {
        state = MyPageState.error(
          message: '정보 업데이트 실패: ${response.statusCode}',
        );
      }
    } catch (e) {
      state = MyPageState.error(message: '정보 업데이트 중 예외 발생: $e');
    }
  }

  void updateNickname(String newNickname) {
    if (state is MyPageStateLoaded) {
      final currentUser = (state as MyPageStateLoaded).user;
      final updatedUser = currentUser.copyWith(nickname: newNickname);
      state = MyPageState.loaded(user: updatedUser);
    }
  }
}

final myInfoViewModelProvider =
StateNotifierProvider<MyPageViewModel, MyPageState>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final secureStorageService = ref.read(myInfoSecureStorageProvider);
  return MyPageViewModel(apiClient, secureStorageService);
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
final myInfoSecureStorageProvider = Provider<SecureStorageService>((ref) => SecureStorageService());
