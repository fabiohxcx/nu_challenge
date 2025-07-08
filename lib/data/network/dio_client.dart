import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// {@category Data Layer}
class DioClient {
  late final Dio _dio;

  // URL base da sua API
  static const String _baseUrl = 'https://url-shortener-server.onrender.com';

  DioClient() {
    // Configurações base do Dio
    final baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );

    _dio = Dio(baseOptions);

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true, responseHeader: false, error: true),
      );
    }
  }

  Future<dynamic> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException {
      rethrow; // Apenas relança a exceção original do Dio
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException {
      rethrow; // Apenas relança a exceção original do Dio
    }
  }
}
