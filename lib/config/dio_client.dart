import 'package:dio/dio.dart';
import 'package:sajilo_bus/config/api_constant.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),

      headers: {
        "Content-Type": "application/json"
      }
    )
  );
}