import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sajilo_bus/config/dio_client.dart';

class AuthService {
  final Dio _dio = DioClient.dio;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response> login({
    required String email,
    required String password,
  }) async {

    // Firebase Login
    UserCredential credential =
    await _auth.signInWithEmailAndPassword(
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
      },
    );
  }

  Future<Response> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {

    //user create garne
    UserCredential credential =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // get firebase token
    String? idToken = await credential.user!.getIdToken();

    //aaba backend ma send grne
    return await _dio.post(
      // "http://192.168.18.162:5000/auth/register",
      "/auth/register",
      data: {
        "idToken": idToken,
        "name": name,
        "phone": phone,
      },
    );
  }
}
