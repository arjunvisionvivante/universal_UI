// lib/viewmodels/forgot_password_view_model.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/services/AuthServices.dart';

import '../ui/secreens/OtpScreen.dart';

class ForgotPasswordViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Input controller
  final emailController = TextEditingController();

  bool get isLoading => _isLoading;

  void validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      sendResetLink(context);
    }
  }

  Future<void> sendResetLink(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final authService = Provider.of<AuthService>(context, listen: false);
    final email = emailController.text.trim();

    try {
      await authService.forgotPassword(email);
      _isLoading = false;
      notifyListeners();
      // Navigate to OTP Verification Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpVerificationScreen(email: email)),
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}