// lib/viewmodels/forgot_password_view_model.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/services/AuthServices.dart';


class ForgotPasswordViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Input controller
  final emailController = TextEditingController();

  // ... getters and setters for controllers

  bool get isLoading => _isLoading;

  // Form Validation
  void validateForm(context) {
    if (formKey.currentState!.validate()) {
      // Proceed with sending the reset link
      sendResetLink(context);
    }
  }

  // Send Reset Link Method
  Future<void> sendResetLink(context) async {
    _isLoading = true;
    notifyListeners();

    final authService = Provider.of<AuthService>(
        // Global context if needed
         context, 
        listen: false);

    final email = emailController.text.trim();

    try {
      await authService.forgotPassword(email);
      // Success handling (e.g., display a message to the user)
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Error handling (e.g., display a snackbar)
      _isLoading = false;
      notifyListeners();
      // ... display an error message to the user 
    }
  }
}