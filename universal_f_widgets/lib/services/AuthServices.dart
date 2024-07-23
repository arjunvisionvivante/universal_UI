// lib/services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_f_widgets/data/repo/networkrepo.dart';
import 'package:universal_f_widgets/models/User.dart';

class AuthService with ChangeNotifier {
  final NetorkinRepository _repository =
      NetorkinRepository("http://nodemaster.visionvivante.com:4040/");

  Future<void> login(String email, String password, context) async {
    final path = 'auth/login';

    final response = await _repository.post(
      path: path,
      data: {'username': email, 'password': password},
      dataMapper: (data) =>
          data, // Adjust the data mapper based on your response structure
    );
    print(response.isSuccess);
    if (response.isSuccess) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      await prefs.setString('userData',
          response.data.toString()); // Save user data as a string or JSON
      Navigator.pushReplacementNamed(context, '/home');
      print("Login successful");
      notifyListeners();
      print("runn");
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.message}')),
      );
      throw Exception("Something goes wrong");
    }
  }

  Future<void> signup(User user, context) async {
    final path = 'auth/signup?role=user';

    final response = await _repository.post(
      path: path,
      data: user.toJson(), // Assuming User model has a toJson() method
      dataMapper: (data) =>
          data, // Adjust the data mapper based on your response structure
    );

    if (response.isSuccess) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      await prefs.setString('userData', response.data.toString());
      print("Signup successful");
      Navigator.pushReplacementNamed(context, '/home');
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.message}')),
      );
      throw Exception(response.message ??
          response.data["message"] ??
          "Something went wrong during signup");
    }
  }
  Future<void> forgotPassword(String email) async {
    final response = await _repository.post(
      path: 'auth/forgot-password/otp',
      dataMapper: (data) => data,
      data: {
        'username': email,
      },
    );

    if (!response.isSuccess) {
      throw Exception(response.message);
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    final response = await _repository.post(
      path: 'auth/verify-otp',
      dataMapper: (data) => data,
      data: {
        'username': email,
        'otp': otp,
      },
    );

    if (!response.isSuccess) {
      throw Exception(response.message);
    }
  }

  Future<void> logout(context) async {
    print("logout ");
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userData');

    Navigator.pushNamedAndRemoveUntil(context, '/login',
        ModalRoute.withName('/')); // Navigate to login screen
  }
  Future<void> resetPassword(String username, String newPassword) async {
    final response = await _repository.post(
      path: 'auth/reset-password',
      dataMapper: (data) => data,
      data: {
        'username': username,
        'password': newPassword,
      },
    );

    if (!response.isSuccess) {
      throw Exception(response.message);
    }
  }
// ... other auth methods (signup, forgot password)
}
