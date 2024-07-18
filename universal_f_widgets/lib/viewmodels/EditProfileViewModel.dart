import 'package:flutter/material.dart';

class EditProfileViewModel with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  bool get isLoading => _isLoading;

  void validateForm(context) {
    if (formKey.currentState!.validate()) {
      // Proceed with saving changes
      saveChanges(context);
    }
  }

  Future<void> saveChanges(context) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate a save operation
      await Future.delayed(Duration(seconds: 2));

      // Success handling
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      // Error handling
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }
  }
}