
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/ResestPassword.dart';
import '../widgets/LoadingIndicator.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String username;

  const ResetPasswordScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late bool _newPasswordVisible;
  late bool _repeatNewPasswordVisible;

  @override
  void initState() {
    super.initState();
    _newPasswordVisible = false;
    _repeatNewPasswordVisible = false;
  }

  final GlobalKey<FormState> _formKeyResPas = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatNewPasswordController = TextEditingController();

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
              child: ChangeNotifierProvider(
                create: (context) => ResetPasswordViewModel(),
                child: Consumer<ResetPasswordViewModel>(
                  builder: (context, viewModel, child) {
                    return Form(
                      key: _formKeyResPas,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 33),
                          Text(
                            "Enter new password",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 13),
                          Text(
                            "Your new password must be different from previously used passwords.",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 33),
                          Text(
                            "Enter new password",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          _buildPasswordTextField(
                            controller: newPasswordController,
                            labelText: "New password",
                            obscureText: !_newPasswordVisible,
                            toggleVisibility: () {
                              setState(() {
                                _newPasswordVisible = !_newPasswordVisible;
                              });
                            },
                          ),
                          SizedBox(height: 19),
                          Text(
                            "Confirm new password",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          _buildPasswordTextField(
                            controller: repeatNewPasswordController,
                            labelText: "Retype new password",
                            obscureText: !_repeatNewPasswordVisible,
                            toggleVisibility: () {
                              setState(() {
                                _repeatNewPasswordVisible = !_repeatNewPasswordVisible;
                              });
                            },
                          ),
                          SizedBox(height: 33),
                          viewModel.isLoading
                              ? LoadingIndicator()
                              : ElevatedButton(
                            onPressed: () {
                              if (_formKeyResPas.currentState!.validate()) {
                                viewModel.resetPassword(
                                  context,
                                  widget.username,
                                  newPasswordController.text,
                                  repeatNewPasswordController.text,
                                );
                              }
                            },
                            child: Text('Change password'),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'The password must be at least 6 characters.';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}