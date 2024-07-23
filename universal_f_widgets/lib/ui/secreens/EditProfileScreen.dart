import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../utils/ValidationHelper.dart';
import '../../viewmodels/EditProfileViewModel.dart';
import '../../viewmodels/ProfileViewModel.dart';
import '../widgets/CustomTextField.dart';
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var profileViewModel = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (!profileViewModel.isLoading) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please wait while the profile is updating')),
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    profileViewModel.setProfilePic(pickedFile.path);
                  }
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: profileViewModel.profilePic.isNotEmpty
                      ? FileImage(File(profileViewModel.profilePic)) as ImageProvider
                      : AssetImage('assets/images/avatar.png'),
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: profileViewModel.firstNameController,
                hintText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: profileViewModel.lastNameController,
                hintText: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: profileViewModel.emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: profileViewModel.dobController.text.isNotEmpty
                        ? DateTime.parse(profileViewModel.dobController.text)
                        : DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    profileViewModel.dobController.text = formattedDate;
                  }
                },
                child: CustomTextField(
                  isDisable: false,
                  controller: profileViewModel.dobController,
                  hintText: 'Date of Birth (YYYY-MM-DD)',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              GooglePlaceAutoCompleteTextField(
                textEditingController: profileViewModel.addressController,
                googleAPIKey: "AIzaSyC5JwGGebkSRvbcbWsbg9bZjO7vNhI3loQ",
                debounceTime: 800,
                countries: ["in"],
                isLatLngRequired: true,
                getPlaceDetailWithLatLng: (prediction) {
                  profileViewModel.latController.text = prediction.lat.toString();
                  profileViewModel.longController.text = prediction.lng.toString();
                  profileViewModel.getPlaceDetails(prediction.placeId!);
                },
                itemClick: (prediction) {
                  profileViewModel.addressController.text = prediction.description!;
                  profileViewModel.cityController.text = prediction.terms![1].value!;
                },
              ),
              SizedBox(height: 16),
              IntlPhoneField(
                controller: profileViewModel.phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  profileViewModel.countryCode = phone.countryCode;
                  print(phone.completeNumber);
                },
                validator: (phone) {
                  return ValidationHelper.validatePhone(phone?.completeNumber);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    profileViewModel.updateProfile(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
