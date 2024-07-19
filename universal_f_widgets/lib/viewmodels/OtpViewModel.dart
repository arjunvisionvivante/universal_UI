import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/ui/secreens/ResetPasswordSecreen.dart';

import '../services/AuthServices.dart';


class OtpVerificationViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String otp = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> verifyOtp(BuildContext context, String email) async {
    _isLoading = true;
    notifyListeners();

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.verifyOtp(email, otp);
      _isLoading = false;
      notifyListeners();
      // Navigate to ResetPasswordScreen after successful OTP verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(username: email),
        ),
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