import 'package:dailystep/data/api/result/api_error.dart';
import 'package:dailystep/widgets/widget_toast.dart';
import 'package:dio/dio.dart';
import '../../config/secure_storage/secure_storage_service.dart';
import '../../feature/home/view/settings/toast_msg.dart';
import 'dio/dio_set.dart';

class ApiClient {
  final Dio _dio = dioSet;
  final _secureStorageService = SecureStorageService();

  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await _secureStorageService.getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options); // 요청 진행
      },
      onResponse: (response, handler) {
        print('ApiClient Response: ${response.data}');
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Access Token이 만료된 경우
          print('토큰 만료: Access Token 갱신 시도');

          final refreshToken = await _secureStorageService.getRefreshToken();

          print('사용 중인 Refresh Token: $refreshToken');

          if (refreshToken != null && refreshToken.isNotEmpty) {
            try {
              // Refresh Token으로 새 Access Token 요청
              final tokenResponse = await _dio.post(
                'auth/reissue',
                data: {'refreshToken': refreshToken},
              );
              print('토큰 갱신 응답: ${tokenResponse.data}');

              if (tokenResponse.statusCode == 200) {
                final responseData = tokenResponse.data['data'];
                final newAccessToken = responseData['accessToken'];
                final newRefreshToken = responseData['refreshToken'];
                final newExpirationTime = responseData['accessTokenExpiresIn'];

                // 새 토큰 저장
                await _secureStorageService.saveAccessToken(newAccessToken,newExpirationTime);
                await _secureStorageService.saveRefreshToken(newRefreshToken);

                // 저장된 Access Token 확인
                final storedAccessToken = await _secureStorageService.getAccessToken();
                final storedRefreshToken = await _secureStorageService.getRefreshToken();

                print('[DEBUG] 저장된 Access Token: $storedAccessToken');
                print('[DEBUG] 저장된 Refresh Token: $storedRefreshToken');

                // 원래 요청에 새 Access Token 추가 후 재시도
                error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                final retryResponse = await _dio.request(
                  error.requestOptions.path,
                  options: Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers,
                  ),
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                return handler.resolve(retryResponse);
              }
            } catch (refreshError) {
              print('Refresh Token도 만료됨: $refreshError');
              // 에러 전달
              return handler.reject(error);
            }
          }
        }
        ApiError.createErrorResult(error).runIfFailure((data){
          ToastMsg toastMsg = ToastMsg.create(4);
          WToast.show(toastMsg.title, subMessage: toastMsg.content);
        });
        return handler.next(error); // 다른 에러 진행
      },
    ));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters, Map<String, String>? headers, Map<String, dynamic>? data}) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw Exception('GET 요청 실패: $e');
    }
  }

  Future<Response> post(String endpoint, {dynamic data, Map<String, String>? headers}) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw Exception('POST 요청 실패: $e');
    }
  }

  Future<Response> put(String endpoint, {dynamic data, Map<String, String>? headers}) async {
    try {
      return await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw Exception('PUT 요청 실패: $e');
    }
  }

  Future<Response> delete(String endpoint, {dynamic data, Map<String, String>? headers}) async {
    try {
      return await _dio.delete(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
    } catch (e) {
      throw Exception('DELETE 요청 실패: $e');
    }
  }
}
