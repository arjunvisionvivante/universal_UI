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
    // ... YOUR ACTUAL FORGOT PASSWORD LOGIC HERE ...
    // Replace this with your real forgot password implementation
    // Example using a simple validation (you'll likely use an API):
    if (email.contains('@')) {
      // ... send a password reset link to the email address
      // ... handle success (e.g., display a message to the user)
      notifyListeners();
    } else {
      // ... forgot password failed (e.g., invalid email)
      // ... handle error (e.g., display a snackbar)
      throw Exception('Invalid email');
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

// ... other auth methods (signup, forgot password)
}
