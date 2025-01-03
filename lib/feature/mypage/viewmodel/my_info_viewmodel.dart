import 'dart:ffi';
import 'dart:io';

import 'package:dailystep/data/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  void updateNickname(String newNickname) {
    if (state is MyPageStateLoaded) {
      final currentUser = (state as MyPageStateLoaded).user;
      final updatedUser = currentUser.copyWith(nickname: newNickname);
      state = MyPageState.loaded(user: updatedUser);
    }
  }

  void updateUserBirth(DateTime newBirthDate) {
    if (state is MyPageStateLoaded) {
      final currentState = state as MyPageStateLoaded;
      state = MyPageState.loaded(
        user: currentState.user.copyWith(birth: newBirthDate),
      );
    }
  }

  void updateUserGender(String newGender) {
    if (state is MyPageStateLoaded) {
      final currentState = state as MyPageStateLoaded;
      state = MyPageState.loaded(
        user: currentState.user.copyWith(gender: newGender),
      );
    }
  }

  void updateUserJob(int newJobId) {
    if (state is MyPageStateLoaded) {
      final currentState = state as MyPageStateLoaded;
      state = MyPageState.loaded(
        user: currentState.user.copyWith(jobId: newJobId),
      );
    }
  }

  void updateUserJobYear(int newJobYearId) {
    if (state is MyPageStateLoaded) {
      final currentState = state as MyPageStateLoaded;
      final updatedUser = currentState.user.copyWith(jobYearId: newJobYearId);
      state = MyPageState.loaded(user: updatedUser);
    }
  }

  Future<void> uploadProfileImage(XFile image) async {
    state = MyPageState.loading();
    print('State set to loading in uploadProfileImage');

    try {
      final token = await _secureStorageService.getAccessToken();
      if (token == null) {
        throw Exception('Access token is missing');
      }

      final fileSizeInBytes = await image.length();
      final maxFileSizeInBytes = 4.99 * 1024 * 1024; // 4.99MB in bytes

      File compressedFile;
      if (fileSizeInBytes > maxFileSizeInBytes) {
        compressedFile = await _compressImage(image);
      } else {
        compressedFile = File(image.path);
      }

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(compressedFile.path),
      });

      final response = await _apiClient.post(
        'member/profile/img',
        data: formData,
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final imageUrl = response.data['data']; // URL 반환

        // 상태가 MyPageStateLoaded인지 확인
        if (response.statusCode == 200) {
          final imageUrl = response.data['data']; // URL 반환

          if (state is MyPageStateLoaded) {
            final currentState = state as MyPageStateLoaded;
            final updatedUser = currentState.user.copyWith(profileImageUrl: imageUrl);
            state = MyPageState.loaded(user: updatedUser);
            print('Profile image updated. State updated to loaded with user: $updatedUser');
          } else {
            // 기본 데이터를 사용해 loaded 상태로 설정
            await fetchUserData();
            if (state is MyPageStateLoaded) {
              final currentState = state as MyPageStateLoaded;
              final updatedUser = currentState.user.copyWith(profileImageUrl: imageUrl);

              state = MyPageState.loaded(user: updatedUser);
              print('State updated to loaded after fetch with updated user: $updatedUser');
            }
          }
        }
      }else {
        state = MyPageState.error(message: 'Image upload failed: ${response.statusCode}');
      }
    } catch (e) {
      state = MyPageState.error(message: 'Image upload error: $e');
    }
  }

  Future<File> _compressImage(XFile image) async {
    final result = await FlutterImageCompress.compressWithFile(
      image.path,
      minWidth: 800,
      minHeight: 800,
      quality: 80,
    );

    if (result == null) {
      throw Exception('Image compression failed');
    }

    return File(image.path)
      ..writeAsBytesSync(result);
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
