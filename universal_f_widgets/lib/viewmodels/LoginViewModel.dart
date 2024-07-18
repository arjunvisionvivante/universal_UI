// lib/viewmodels/login_view_model.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/services/AuthServices.dart';

class LoginViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>(); // Define _formKey here
  bool _isLoading = false;

  // Input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ... getters and setters for controllers

  bool get isLoading => _isLoading;

  // Form Validation
  void validateForm(context) {
    if (formKey.currentState!.validate()) {
      // Proceed with login
      login(context);
    }
  }

  // Login Method
  Future<void> login(context) async {
    _isLoading = true;
    notifyListeners();

    final authService = Provider.of<AuthService>(
        // Global context if needed
        context,
        listen: false);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      await authService.login(email, password, context);
      // Success handling (e.g., navigate to the home screen)
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
