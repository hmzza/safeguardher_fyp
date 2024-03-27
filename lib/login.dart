import 'package:flutter/material.dart';
import 'package:safeguardher/changepassword.dart';
import 'package:safeguardher/home_page.dart';
import 'package:safeguardher/signup.dart';
import 'package:safeguardher/utils/mainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class mylogin extends StatefulWidget {
  const mylogin({super.key});

  @override
  State<mylogin> createState() => _myloginState();
}

class _myloginState extends State<mylogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushNamed(
        context,
        '/main_screen'
      );
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color(0xA0FF0000),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/loginpage.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0),
                Image.asset('assets/images/logo.png', width: 400),
                SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.85),
                    filled: true,
                    hintText: 'Email',
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
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFF54184),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text('Login'),
                  onPressed: _login,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Color(0xFFF54184),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  child: const Text('Sign in with Google',style: TextStyle(fontSize: 5,color: Colors.white)),
                  onPressed: _signInWithGoogle,
                ),
                TextButton(
                  child: Text('Forget Password?', style: TextStyle(color: Colors.white)),
                  onPressed: () {

                    Navigator.pushNamed(context, '/changepassword');
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePwd()));
                  },
                ),
                TextButton(
                  child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                  onPressed: () {

                    Navigator.pushNamed(context, '/signup');
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
                TextButton(
                  child: Text('TEMPORARY BYPASS AUTHENTICATION', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/main_screen');
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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