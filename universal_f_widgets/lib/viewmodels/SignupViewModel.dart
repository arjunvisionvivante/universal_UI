// lib/viewmodels/signup_view_model.dart


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/services/AuthServices.dart';
import '../models/User.dart';

class SignupViewModel with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Input controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String? countryCode;

  bool get isLoading => _isLoading;

  // Handle address selection
  Future<void> getPlaceDetails(String placeId) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyC5JwGGebkSRvbcbWsbg9bZjO7vNhI3loQ'));

    if (response.statusCode == 200) {
      final placeDetails = json.decode(response.body);
      for (var component in placeDetails['result']['address_components']) {
        if (component['types'].contains('postal_code')) {
          pincodeController.text = component['long_name'];
          break;
        }
        if (component['types'].contains('country')) {
          print('Country ID: ${component['short_name']}');
        }
      }
    } else {
      throw Exception('Failed to load place details');
    }
    notifyListeners();
  }

  // Form Validation
  void validateForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Proceed with signup
      signup(context);
    }
  }

  // Signup Method
  Future<void> signup(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    final user = User(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      dob: dobController.text.trim(),
      address: Address(
        street: addressController.text.trim(),
        city: cityController.text.trim(),
        zipCode: pincodeController.text.trim(),
        // Include other address fields as necessary
      ),
      phoneNumber: phoneNumberController.text.trim(),
      countrycode: countryCode,
    );

    try {
      await authService.signup(user, context);
      // Success handling (e.g., navigate to the login screen)
    } catch (e) {
      // Error handling (e.g., display a snackbar)
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
