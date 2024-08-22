import 'package:dio/dio.dart';

class DioClient {
  static Dio dio = Dio();
  static String? _token;
  static void initializeDio(String token) {
    dio.interceptors.clear(); // Clear previous interceptors
    _token = token;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add the authorization header to every request
          print(
              'Interceptor triggered ----------------------- Adding Authorization header');
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          return handler.next(options); // Continue with the request
        },
        onError: (DioException e, handler) {
          // Handle errors like token expiration here
          if (e.response?.statusCode == 401) {
            throw Exception('Unauthorized access, possily token exired: $e');
          }
          return handler.next(e); // Continue with the error handling
        },
      ),
    );
  }
}
