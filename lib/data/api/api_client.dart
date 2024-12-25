import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dio/dio_set.dart';

class ApiClient {
  final Dio _dio = dioSet;
  final _secureStorage = const FlutterSecureStorage();

  ApiClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await _secureStorage.read(key: 'accessToken');

        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options); // 요청 진행
      },
      onResponse: (response, handler) {
        print('Response: ${response.data}');
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Access Token이 만료된 경우
          final refreshToken = await _secureStorage.read(key: 'refreshToken');
          if (refreshToken != null && refreshToken.isNotEmpty) {
            try {
              // Refresh Token으로 새 Access Token 요청
              final tokenResponse = await _dio.post(
                'auth/reissue',
                data: {'refresh_token': refreshToken},
              );

              if (tokenResponse.statusCode == 200) {
                final newAccessToken = tokenResponse.data['access_token'];
                // 새 토큰 저장
                await _secureStorage.write(key: 'accessToken', value: newAccessToken);

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
        return handler.next(error); // 다른 에러 진행
      },
    ));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) async {
    try {
      return await _dio.get(
        endpoint,
        queryParameters: queryParameters,
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
