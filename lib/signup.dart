import 'package:flutter/material.dart';
import 'package:safeguardher/home_page.dart';
import 'package:safeguardher/login.dart';
// import 'package:safeguardher/utils/mainScreen.dart'; // If you're using this for navigation

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _CNICController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginpage.png'), // Replace with your actual path to background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Image.asset('assets/images/logo.png', width: 200), // Replace with your actual path to logo
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(
                      controller: _usernameController,
                      hintText: 'Username',
                      icon: Icons.person,
                    ),
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    _buildTextField(
                      controller: _CNICController,
                      hintText: 'CNIC',
                      icon: Icons.info,
                    ),
                    _buildTextField(
                      controller: _ageController,
                      hintText: 'Age',
                      icon: Icons.cake,
                    ),
                    _buildTextField(
                      controller: _addressController,
                      hintText: 'Address',
                      icon: Icons.home,
                    ),
                    _buildTextField(
                      controller: _phoneNoController,
                      hintText: 'Contact',
                      icon: Icons.phone,
                    ),
                    _buildTextField(
                      controller: _countryController,
                      hintText: 'Country',
                      icon: Icons.flag,
                    ),
                    _buildTextField(
                      controller: _cityController,
                      hintText: 'City',
                      icon: Icons.location_city,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Sign Up'),
              onPressed: _signUp,
            ),
            TextButton(
              child: Text('Already have an account? Login', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => mylogin()));
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.85),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          prefixIcon: Icon(icon, color: Colors.pink.shade900),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _signUp() {
    // Implement your signup logic
    // For demonstration, after sign up, navigate to MainScreen or a confirmation page
    Navigator.push(context, MaterialPageRoute(builder: (context) => home_page()));
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _CNICController.dispose();
    _phoneNoController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    super.dispose();
  }

// ...
}

