// lib/ui/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/ui/widgets/CustomTextField.dart';
import 'package:universal_f_widgets/ui/widgets/LoadingIndicator.dart';
import 'package:universal_f_widgets/utils/ValidationHelper.dart';
import 'package:universal_f_widgets/viewmodels/ForgotPasswordViewModel.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => ForgotPasswordViewModel(),
          child: Consumer<ForgotPasswordViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                key: viewModel.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: viewModel.emailController,
                      hintText: 'Email',
                      validator: ValidationHelper.validateEmail,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: viewModel.isLoading ? null : () => viewModel.validateForm(context),
                      child: Text('Send Reset Link'),
                    ),
                    if (viewModel.isLoading) LoadingIndicator(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}