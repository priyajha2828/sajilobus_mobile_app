import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_services.dart';

class AuthProvider extends ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  final AuthService _authService = AuthService();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _recoveryEmailController = TextEditingController();

  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController => _confirmPasswordController;
  TextEditingController get recoveryEmailController => _recoveryEmailController;

  List<TextEditingController> get otpControllers => _otpControllers;

  // Errors
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get phoneError => _phoneError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;

  // Toggle Password
  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Remember Me
  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? !_rememberMe;
    notifyListeners();
  }

  // Error Setters
  void setNameError(String? value) {
    _nameError = value;
    notifyListeners();
  }

  void setEmailError(String? value) {
    _emailError = value;
    notifyListeners();
  }

  void setPhoneError(String? value) {
    _phoneError = value;
    notifyListeners();
  }

  void setPasswordError(String? value) {
    _passwordError = value;
    notifyListeners();
  }

  void setConfirmPasswordError(String? value) {
    _confirmPasswordError = value;
    notifyListeners();
  }

  // Email Validation
  bool _isValidEmail(String email) {
    return RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);
  }

  // Login Validation
  bool validateLogin() {
    bool valid = true;

    if (_emailController.text.trim().isEmpty) {
      setEmailError("Email is required");
      valid = false;
    } else if (!_isValidEmail(_emailController.text.trim())) {
      setEmailError("Enter a valid email");
      valid = false;
    } else {
      setEmailError(null);
    }

    if (_passwordController.text.isEmpty) {
      setPasswordError("Password is required");
      valid = false;
    } else if (_passwordController.text.length < 6) {
      setPasswordError("Password must be at least 6 characters");
      valid = false;
    } else {
      setPasswordError(null);
    }

    return valid;
  }

  // Signup Validation
  bool validateRegister() {
    bool valid = true;

    if (_nameController.text.trim().isEmpty) {
      setNameError("Name is required");
      valid = false;
    } else {
      setNameError(null);
    }

    if (_emailController.text.trim().isEmpty) {
      setEmailError("Email is required");
      valid = false;
    } else if (!_isValidEmail(_emailController.text.trim())) {
      setEmailError("Enter a valid email");
      valid = false;
    } else {
      setEmailError(null);
    }

    if (_phoneController.text.trim().isEmpty) {
      setPhoneError("Phone number is required");
      valid = false;
    } else if (_phoneController.text.length != 10) {
      setPhoneError("Phone number must be 10 digits");
      valid = false;
    } else {
      setPhoneError(null);
    }

    if (_passwordController.text.isEmpty) {
      setPasswordError("Password is required");
      valid = false;
    } else if (_passwordController.text.length < 6) {
      setPasswordError("Password must be at least 6 characters");
      valid = false;
    } else {
      setPasswordError(null);
    }

    if (_confirmPasswordController.text !=
        _passwordController.text) {
      setConfirmPasswordError("Passwords do not match");
      valid = false;
    } else {
      setConfirmPasswordError(null);
    }

    return valid;
  }

  // Login
  Future<bool> login() async {

    if (!validateLogin()) {
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE: ${response.data}");

      if (response.data["success"] == true) {
        return true;
      }

      return false;
    } on DioException catch (e) {
      print("DIO ERROR");
      print(e.response?.statusCode);
      print(e.response?.data);
      return false;
    } catch (e) {
      print(e);
      return false;
    } finally {

      _isLoading = false;
      notifyListeners();

    }
  }

  // Register
  Future<bool> register() async {
    if(!validateRegister()){
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try{
      final response =
      await _authService.register(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,

      );
      debugPrint(response.data.toString());
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }

    catch(e){

      debugPrint(e.toString());
      return false;

    }

    finally{

      _isLoading = false;
      notifyListeners();

    }

  }

  Future<void> sendRecoveryLink() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> verifyOtp(BuildContext context) async {
    String code =
    _otpControllers.map((e) => e.text).join();

    if (code.length != 6) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _recoveryEmailController.clear();

    _nameError = null;
    _emailError = null;
    _phoneError = null;
    _passwordError = null;
    _confirmPasswordError = null;

    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _recoveryEmailController.dispose();

    for (final controller in _otpControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}