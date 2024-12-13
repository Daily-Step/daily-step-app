import 'package:dio/dio.dart';

import 'dio/dio_set.dart';

class ApiClient{
  final Dio _dio = dioSet;

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      throw Exception('GET 요청 실패: $e');
    }
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      throw Exception('POST 요청 실패: $e');
    }
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      throw Exception('PUT 요청 실패: $e');
    }
  }

  Future<Response> delete(String endpoint, {dynamic data}) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } catch (e) {
      throw Exception('DELETE 요청 실패: $e');
    }
  }
}
