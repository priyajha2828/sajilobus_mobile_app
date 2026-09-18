import 'package:dio/dio.dart';
import 'package:sajilo_bus/config/dio_client.dart';

class DriverService {
  final Dio _dio = DioClient.dio;

  Future<Response> getProfile(String token) async {
    return await _dio.get(
      "/driver-profile/me",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> getAssignment(String token) async {
    return await _dio.get(
      "/driver-profile/me/assignment",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> toggleAvailability(String token, bool isAvailable) async {
    return await _dio.patch(
      "/driver-profile/me/availability",
      data: {"isAvailable": isAvailable},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> updateProfile(String token, Map<String, dynamic> data) async {
    return await _dio.patch(
      "/driver-profile/me",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> startTrip(String token, Map<String, dynamic> data) async {
    return await _dio.post(
      "/trips/start",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> endTrip(String token, int tripId) async {
    return await _dio.post(
      "/trips/$tripId/end",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> recordLocation(String token, int tripId, double lat, double lng, {double? speed, double? heading}) async {
    return await _dio.post(
      "/trips/$tripId/location",
      data: {
        "latitude": lat,
        "longitude": lng,
        if (speed != null) "speed": speed,
        if (heading != null) "heading": heading,
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> getTripHistory(String token) async {
    return await _dio.get(
      "/trips/history",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> getCurrentStopDetails(String token, int tripId) async {
    return await _dio.get(
      "/trips/$tripId/current-stop",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> departStop(String token, int tripId, Map<String, dynamic> data) async {
    return await _dio.post(
      "/trips/$tripId/depart-stop",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> triggerSOS(String token, Map<String, dynamic> data) async {
    return await _dio.post(
      "/sos",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
