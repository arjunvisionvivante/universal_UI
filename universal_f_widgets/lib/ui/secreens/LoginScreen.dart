// lib/ui/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/ui/widgets/CustomTextField.dart';
import 'package:universal_f_widgets/utils/ValidationHelper.dart';
import 'package:universal_f_widgets/viewmodels/LoginViewModel.dart';

// Update with your actual path

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container( padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
            child: Consumer<LoginViewModel>(
              builder: (context, viewModel, child) {
                return Form(
                  key: viewModel.formKey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // Social login buttons
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
                      // Email field
                      CustomTextField(
                        controller: viewModel.emailController,
                        hintText: 'Email',
                        validator: ValidationHelper.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      // Password field
                      CustomTextField(
                        controller: viewModel.passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        validator: ValidationHelper.validatePassword,
                      ),
                      SizedBox(height: 20),
                      // Sign in button
                      ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null
                            : () {
                                viewModel.validateForm(context);
                              },
                        child: Text('Sign in'),
                      ),
                      SizedBox(height: 10),
                      // Forgot password
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text('Forgot password?'),
                      ),
                      // Create account
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('Don\'t you have an account?'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
