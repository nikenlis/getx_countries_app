import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://restcountries.com/v3.",

        connectTimeout: const Duration(seconds: 10),

        receiveTimeout: const Duration(seconds: 10),

        headers: {
          "Content-Type": "application/json",

          "Accept": "application/json",
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,

        responseBody: true,
        responseHeader: false,

        error: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          final responseData = e.response?.data;

          final message = responseData is Map<String, dynamic>
              ? responseData["message"]
              : null;

          switch (e.type) {
            case DioExceptionType.connectionTimeout:
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,

                  error: "Connection timeout",
                ),
              );

            case DioExceptionType.receiveTimeout:
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,

                  error: "Receive timeout",
                ),
              );

            case DioExceptionType.sendTimeout:
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,

                  error: "Send timeout",
                ),
              );

            case DioExceptionType.badResponse:
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,

                  error: message ?? "Server error",
                ),
              );

            case DioExceptionType.connectionError:
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,

                  error: "No internet connection",
                ),
              );

            default:
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,

                  error: e.message ?? "Something went wrong",
                ),
              );
          }
        },
      ),
    );
  }
}
