import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import '../data/repo/networkrepo.dart';

class ProfileViewModel with ChangeNotifier {
  final NetorkinRepository _repository =
  NetorkinRepository("http://nodemaster.visionvivante.com:4040/");
  String? countryCode;
  bool isLoading=false;
String ctr_code="";
  final emailController = TextEditingController();
String picture="";
  String profilePic = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String dob = '';
  String address = '';
  String phoneNumber = '';
  String role = '';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  final usernameController = TextEditingController();
  final latController =TextEditingController();
  final  longController=TextEditingController();
  final cityController=TextEditingController();



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
      picture=profileData["profile_pic"] ?? '';
      firstName = profileData['first_name'] ?? '';
      lastName = profileData['last_name'] ?? '';
      email = profileData['email'] ?? '';
      dob = profileData['dob'] ?? '';
      address = profileData['address'] ?? '';
      phoneNumber = profileData['phone_number']?.toString() ?? '';
      role = profileData['role'] ?? '';
      ctr_code=profileData['country_code'];
      emailController.text = profileData['email'] ?? '';
      firstNameController.text = profileData['first_name'] ?? '';
      lastNameController.text = profileData['last_name'] ?? '';
      dobController.text = profileData['dob'] ?? '';
      addressController.text = profileData['address'] ?? '';
      phoneNumberController.text =  profileData['phone_number'].toString() ?? '';
      countryCodeController.text = profileData['country_code'] ?? '';
      usernameController.text = profileData['username'] ?? '';

      notifyListeners();
    } else {
      // Handle error
      print('Error: ${response.message}');
    }
  }

  void setProfilePic(String path) {
    profilePic = path;
    notifyListeners();
  }
  Future<void> getPlaceDetails(String placeId) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyC5JwGGebkSRvbcbWsbg9bZjO7vNhI3loQ'));

    if (response.statusCode == 200) {
      final placeDetails = json.decode(response.body);
      for (var component in placeDetails['result']['address_components']) {
        if (component['types'].contains('postal_code')) {
          var pincodeController;
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

  Map<String, dynamic> getChangedValues() {

    Map<String, dynamic> changedValues = {};
    if (firstNameController.text != firstName) {
      changedValues['first_name'] = firstNameController.text;
    }
    if (lastNameController.text != lastName) {
      changedValues['last_name'] = lastNameController.text;
    }
    if (dobController.text != dob) {
      changedValues['dob'] = dobController.text;
    }
    if (addressController.text != address) {
      changedValues['address'] = addressController.text;
    }
    if (phoneNumberController.text != phoneNumber) {
      changedValues['phone_number'] = phoneNumberController.text;
    }
    if (countryCodeController.text != ctr_code) {
      changedValues['country_code'] = countryCodeController.text;
    }


    return changedValues;
  }
  Future<void> updateProfilePic(String imagePath) async {
    final path = 'profile/edit';
    final file = File(imagePath);

    isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.putMultipart(
        path: path,
        dataMapper: (data) => data,
        file: file,
        fileField: 'profile_pic',
      );

      if (response.isSuccess) {
        profilePic = imagePath;
        notifyListeners();
        // Handle successful update, e.g., show a success message
      } else {
        // Handle error
        print('Error: ${response.data}');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<void> updateProfile(BuildContext context) async {
    final path = 'profile/edit';
    isLoading=true;
    notifyListeners();

    final changedValues = getChangedValues();
    try {
      final response = await _repository.put(
        path: path,
        data: changedValues,
        dataMapper: (data) => data,
      );

      if (response.isSuccess) {
        // Handle successful update
        print('Profile updated successfully');
        notifyListeners();
        Navigator.pop(context); // Return to profile view
      } else {
        // Handle error
        print('Error: ${response.message}');
      }
    } finally {
      isLoading=false;
    }
  }
}
