import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/ValidationHelper.dart';
import '../../viewmodels/EditProfileViewModel.dart';
import '../widgets/CustomTextField.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => EditProfileViewModel(),
          child: Consumer<EditProfileViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                key: viewModel.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: viewModel.emailController,
                        hintText: 'Email',
                        validator: ValidationHelper.validateEmail,
                      ),
                      CustomTextField(
                        controller: viewModel.firstNameController,
                        hintText: 'First Name',
                        validator: ValidationHelper.validateName,
                      ),
                      CustomTextField(
                        controller: viewModel.lastNameController,
                        hintText: 'Last Name',
                        validator: ValidationHelper.validateName,
                      ),
                      CustomTextField(
                        controller: viewModel.dobController,
                        hintText: 'Date of Birth',
                        validator: ValidationHelper.validateDOB,
                      ),
                      CustomTextField(
                        controller: viewModel.addressController,
                        hintText: 'Address',
                        validator: ValidationHelper.validateAddress,
                      ),
                      CustomTextField(
                        controller: viewModel.phoneController,
                        hintText: 'Phone Number',
                        validator: ValidationHelper.validatePhone,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () => viewModel.validateForm(context),
                        child: Text('Save Changes'),
                      ),
                      if (viewModel.isLoading) CircularProgressIndicator(),
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
