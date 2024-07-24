import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_f_widgets/services/AuthServices.dart';

import '../../utils/ValidationHelper.dart';
import '../widgets/CustomTextField.dart';

class ChangePaswordPage extends StatefulWidget {
  const ChangePaswordPage({super.key});

  @override
  State<ChangePaswordPage> createState() => _ChangePaswordPageState();
}

class _ChangePaswordPageState extends State<ChangePaswordPage> {
  final GlobalKey<FormState> _formKeyResPas = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
@override
  void dispose() {
   newPasswordController.dispose();
   currentPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Reset Password')),
        backgroundColor: Colors.white,
        body: Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKeyResPas,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 33),
                    Text(
                      "Enter Current  password",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 13),
                    CustomTextField(
                      controller: currentPassword,
                      hintText: ' Current Password',
                      obscureText: true,
                      validator: ValidationHelper.validatePassword,
                    ),
                    SizedBox(height: 19),
                    Text(
                      "New password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: newPasswordController,
                      hintText: 'New Password',
                      obscureText: true,
                      validator: ValidationHelper.validatePassword,
                    ),
                    SizedBox(height: 33),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKeyResPas.currentState!.validate()) {
                          context.read<AuthService>().changePassword(
                              currentPassword.text,
                              newPasswordController.text,
                              context);
                        }
                      },
                      child: Text('Change password'),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
