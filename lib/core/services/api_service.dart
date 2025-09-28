import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:3000", // iOS için
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  String get baseUrl => _dio.options.baseUrl;

  // GET isteği
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }

  // POST isteği
  Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  // PUT isteği
  Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  // DELETE isteği
  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
