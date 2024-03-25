import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safeguardher/login.dart'; // Adjust the path as necessary

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  bool _isLoading = false;

  void _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Attempt to store the user's data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'contactNo': _contactNoController.text.trim(),
      }).then((_) {
        Fluttertoast.showToast(
          msg: "User data stored successfully.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }).stillcatchError((error) {
    // Handle errors with storing data in Firestore
    print("Error writing to Firestore: $error");
    Fluttertoast.showToast(
    msg: "Error writing to Firestore: ${error.message}", // Make sure to print the actual error message
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
    );
    });


    Fluttertoast.showToast(
        msg: "Sign Up Successful. Please login.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mylogin()));
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth errors
      var errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xA0FF0000),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      // Handle any other errors
      Fluttertoast.showToast(
        msg: "An unexpected error occurred.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Color(0xA0FF0000),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginpage.png'),
            // Your path to background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: 200),
                  // Your path to logo
                  _buildTextField(
                      _nameController, 'Full Name', Icons.person, false),

                  _buildTextField(
                      _emailController, 'Email', Icons.email, false),
                  _buildTextField(
                      _contactNoController, 'Contact No', Icons.phone, false),
                  _buildTextField(
                      _passwordController, 'Password', Icons.lock, true),
                  _buildTextField(_confirmPasswordController,
                      'Confirm Password', Icons.lock, true),
                  SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : _buildSignUpButton(),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      IconData icon, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (value) => _validateInput(value, hintText, controller),
        decoration: InputDecoration(
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black54),
          prefixIcon: Icon(icon, color: Colors.pink.shade900),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFFF54184),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      ),
      child: const Text('Sign Up'),
      onPressed: _signUp,
    );
  }

  Widget _buildLoginButton() {
    return TextButton(
      child: Text('Already have an account? Login',
          style: TextStyle(color: Colors.white)),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => mylogin()));
      },
    );
  }

  String? _validateInput(
      String? value, String fieldName, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    switch (fieldName) {
      case 'Name':
        if (value == null || value.isEmpty) {
          return 'Please enter a valid Name';
        }
      case 'Email':
        if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        break;
      case 'Password':
        if (value.length < 5) {
          return 'Password must be at least 5 characters';
        }
        break;
      case 'Confirm Password':
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        break;
      case 'Contact No':
        if (value.length < 10) {
          return 'Please enter a valid contact number';
        }
        break;
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _contactNoController.dispose();
    super.dispose();
  }
}
