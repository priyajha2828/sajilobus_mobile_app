import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sajilo_bus/config/dio_client.dart';

class AuthService {
  final Dio _dio = DioClient.dio;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    // Firebase Login
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Firebase ID Token
    String? idToken = await credential.user!.getIdToken();

    // Backend Login
    return await _dio.post(
      "/auth/login",
      data: {
        "idToken": idToken,
        "email": email,
      },
    );
  }

  Future<Response> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    // User create in Firebase
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get Firebase Token
    String? idToken = await credential.user!.getIdToken();

    // Send to Backend
    return await _dio.post(
      "/auth/signup",
      data: {
        "idToken": idToken,
        "name": name,
        "email": email,
        "phone": phone,
      },
    );
  }

  Future<Response> getMe(String token) async {
    return await _dio.get(
      "/auth/me",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
