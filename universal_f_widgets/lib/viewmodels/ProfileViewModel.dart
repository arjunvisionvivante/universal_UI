import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/repo/networkrepo.dart'; // Import your networkin repository

class ProfileViewModel with ChangeNotifier {
  final emailController = TextEditingController();
  String profilePic = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String dob = '';
  String address = '';
  String phoneNumber = '';
  String role = '';

  final NetorkinRepository _repository = NetorkinRepository("http://nodemaster.visionvivante.com:4040/");

  ProfileViewModel() {
    // Initialize with fetching profile or other initial data if necessary
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final path = 'profile';

    final response = await _repository.get(
      path: path,
      dataMapper: (data) => data, // Use data['data'] to access nested data

      // Adjust the data mapper based on your response structure
    );

    if (response.isSuccess) {
      // Parse and use the data
      final profileData = response.data;
print(profileData.runtimeType);
      // Update instance variables based on response
      profilePic = profileData["profile_pic"] ?? '';
      firstName = profileData['first_name'] ?? '';
      lastName = profileData['last_name'] ?? '';
      email = profileData['email'] ?? '';
      dob = profileData['dob'] ?? '';
      address = profileData['address'] ?? '';
      phoneNumber = profileData['phone_number']?.toString() ?? '';
      role = profileData['role'] ?? '';

      notifyListeners();
    } else {
      // Handle error
      print('Error: ${response.message}');
    }
  }
}
