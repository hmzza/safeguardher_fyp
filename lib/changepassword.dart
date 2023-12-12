import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({super.key});

  @override
  State<ChangePwd> createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Change Password'),
      body: Stack(
        children: <Widget>[
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/settingsBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Change Password Form
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Create a New Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your new password must be different from previous used passwords.',
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    _buildPasswordTextField(
                        controller: _oldPasswordController,
                        labelText: 'Old Password'),
                    SizedBox(height: 16),
                    _buildPasswordTextField(
                        controller: _newPasswordController,
                        labelText: 'New Password',
                        helperText: 'Must be at least 8 characters'),
                    SizedBox(height: 16),
                    _buildPasswordTextField(
                        controller: _confirmPasswordController,
                        labelText: 'Confirm Password',
                        helperText: 'Both passwords must match'),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Button color
                        onPrimary: Colors.red, // Text color
                      ),
                      onPressed: _changePassword,
                      child: Text('Reset Password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String labelText,
    String? helperText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true, // Hide password
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        helperText: helperText,
        helperStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      validator: (value) {
        // Add your validation logic here
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        if (labelText == 'New Password' && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        if (labelText == 'Confirm Password' &&
            _newPasswordController.text != value) {
          return 'Passwords do not match';
        }
        return null; // Return null if the input is valid
      },
    );
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar and process the password change
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Processing Data')),
      );
      // TODO: Implement the password change logic
      // For example, you might call an API to change the user's password here
    }
  }
}
