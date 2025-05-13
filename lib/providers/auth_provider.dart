import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  User? currentUser;
  bool isCheckingAuth = true;

  Future<void> checkLoginStatus() async {
    currentUser = FirebaseAuth.instance.currentUser;
    isCheckingAuth = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user != null;
    } catch (e) {
      print("Login failed: $e");
      return false;
    }
  }

  Future<User?> signUp(String email, String password) async {
    return await _authService.registerWithEmailAndPassword(email, password);
  }

  Future<void> forgotPass(String email) async {
    await _authService.forgotPass(email);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
