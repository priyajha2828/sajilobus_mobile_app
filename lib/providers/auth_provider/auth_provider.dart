import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obsurePassword => _obscurePassword;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  String? _emailError;
  String? get emailError => _emailError;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _recoveryEmailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get recoveryEmailController => _recoveryEmailController;
  List<TextEditingController> get otpControllers => _otpControllers;
  void togglePassword() {
  _obscurePassword = !_obscurePassword;
  notifyListeners();
  }

  void toggleRememberMe(bool? value) {
  _rememberMe = value ?? !_rememberMe;
  notifyListeners();
  }

  void setEmailError(String? error) {
  _emailError = error;
  notifyListeners();
  }

  Future<bool> login() async {
  if (_emailController.text.isEmpty) {
  setEmailError("Enter an email address");
  return false;
  }

  setEmailError(null);
  _isLoading = true;
  notifyListeners();

  await Future.delayed(const Duration(seconds: 2));

  _isLoading = false;
  notifyListeners();
  return true;
  }

  Future<void> sendRecoveryLink() async {
  if (_recoveryEmailController.text.isEmpty) return;
  _isLoading = true;
  notifyListeners();

  await Future.delayed(const Duration(seconds: 2));

  _isLoading = false;
  notifyListeners();
  }

  Future<void> verifyOtp(BuildContext context) async {
  String fullCode = _otpControllers.map((controller) => controller.text).join();
  if (fullCode.length < 6)return;
  _isLoading = true;
  notifyListeners();

  await Future.delayed(const Duration(seconds:2));

  _isLoading = false;
  notifyListeners();

  }

  Future<void> LoginWithGoogle() async {
  debugPrint("google login clicked");
  }

  Future<void> LoginWithApple() async {
  debugPrint("apple login clicked");
  }

  void clear() {
  _emailController.clear();
  _passwordController.clear();
  _recoveryEmailController.clear();
  _emailError = null;
  _rememberMe = false;
  notifyListeners();
  }

  @override
  void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  _recoveryEmailController.dispose();
  super.dispose();
  }
  }
