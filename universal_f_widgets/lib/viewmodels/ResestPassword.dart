import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/AuthServices.dart';

class ResetPasswordViewModel with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> resetPassword(
      BuildContext context,
      String username,
      String newPassword,
      String repeatNewPassword,
      ) async {
    if (newPassword != repeatNewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.resetPassword(username, newPassword);
      _isLoading = false;
      notifyListeners();
      // Navigate to success page or show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successful')),

      );
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}