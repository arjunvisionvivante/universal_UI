import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/OtpViewModel.dart';
import '../widgets/LoadingIndicator.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;

  OtpVerificationScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => OtpVerificationViewModel(),
          child: Consumer<OtpVerificationViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter the OTP sent to $email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      viewModel.otp = value;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () => viewModel.verifyOtp(context, email),
                    child: Text('Verify OTP'),
                  ),
                  if (viewModel.isLoading) LoadingIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
