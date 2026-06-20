import 'package:dio/dio.dart';

class LogiSphereApiClient {
  final Dio _dio;
  
  // Update this base URL to point to your FastAPI / Node.js backend environment
  static const String baseUrl = "https://api.logisphere.ai/v1";

  LogiSphereApiClient() : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception('Network Request Failed: ${e.message}');
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw Exception('Network Request Failed: ${e.message}');
    }
  }
}