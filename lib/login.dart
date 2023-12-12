import 'package:flutter/material.dart';
import 'package:safeguardher/changepassword.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/forgetpassword.dart';
import 'package:safeguardher/home_page.dart';
import 'package:safeguardher/signup.dart';
import 'package:safeguardher/utils/mainScreen.dart';

class mylogin extends StatefulWidget {
  const mylogin({super.key});

  @override
  State<mylogin> createState() => _myloginState();
}

class _myloginState extends State<mylogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/loginpage.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0),
                Image.asset('assets/images/logo.png', width: 400), // Logo
                SizedBox(height: 48), // Space between logo and text field
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.85),
                    filled: true,
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.85),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, // Button color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                  },
                ),
                TextButton(
                  child: Text('Forget Password?', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePwd()));
                  },
                ),
                TextButton(
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
