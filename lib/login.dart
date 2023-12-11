import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login2.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.55,
                    right: 65,
                    left: 65),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade50,
                          filled: true,
                          hintText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade50,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 52,
                        width: 220,
                        //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                          child: const Text('Login'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new MainScreen()));
                          },
                        )),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      child: TextButton(
                        child: Text('Forget Password?'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new AppBarApp()));
                        },
                      ),
                    ),

                    Container(
                      child: TextButton(
                        child: Text('Sign Up'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new signup()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
