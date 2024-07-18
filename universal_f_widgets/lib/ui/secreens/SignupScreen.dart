// lib/ui/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/ui/widgets/CustomTextField.dart';
import 'package:universal_f_widgets/ui/widgets/LoadingIndicator.dart';
import 'package:universal_f_widgets/utils/ValidationHelper.dart';
import 'package:universal_f_widgets/viewmodels/SignupViewModel.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => SignupViewModel(),
          child: Consumer<SignupViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                key: viewModel.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Social signup buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.login),
                            label: Text('Google'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.grey),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.login),
                            label: Text('Facebook'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: viewModel.emailController,
                        hintText: 'Email',
                        validator: ValidationHelper.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: viewModel.passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: ValidationHelper.validatePassword,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: viewModel.firstNameController,
                        hintText: 'First Name',
                        validator: ValidationHelper.validateName,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: viewModel.lastNameController,
                        hintText: 'Last Name',
                        validator: ValidationHelper.validateName,
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          viewModel.dobController.text = "";
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                            viewModel.dobController.text = formattedDate;
                          }
                        },
                        child: CustomTextField(
                          isDisable: false,
                          controller: viewModel.dobController,
                          hintText: 'Date of Birth (YYYY-MM-DD)',
                          keyboardType: TextInputType.datetime,
                          validator: ValidationHelper.validateDOB,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Google Place Autocomplete TextField
                      GooglePlaceAutoCompleteTextField(
                        textEditingController: viewModel.addressController,
                        googleAPIKey: "AIzaSyC5JwGGebkSRvbcbWsbg9bZjO7vNhI3loQ",
                        // Replace with your API key
                        debounceTime: 800,
                        countries: ["in"],
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (prediction) {
                          viewModel.latController.text =
                              prediction.lat.toString();
                          viewModel.longController.text =
                              prediction.lng.toString();
                          viewModel.getPlaceDetails(prediction.placeId!);
                        },
                        itemClick: (prediction) {
                          viewModel.addressController.text =
                              prediction.description!;
                          viewModel.cityController.text =
                              prediction.terms![1].value!;
                        },
                      ),
                      SizedBox(height: 20),
                      IntlPhoneField(
                        controller: viewModel.phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          viewModel.countryCode = phone.countryCode;
                          print(phone.completeNumber);
                        },
                        validator: (phone) {
                          return ValidationHelper.validatePhone(
                              phone?.completeNumber);
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () => viewModel.validateForm(context),
                        child: Text('Sign up'),
                      ),
                      if (viewModel.isLoading) LoadingIndicator(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
