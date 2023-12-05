import 'package:flutter/material.dart';
import 'package:safeguardher/checkmail.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/login.dart';
import 'package:safeguardher/signup.dart';
import 'package:safeguardher/forgetpassword.dart';

import 'home_page.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: 'login',
    debugShowCheckedModeBanner: false,
    routes: {
      'login': (context)=>mylogin(),
      'signup': (context)=>signup(),
      'forgetpassword': (context)=>AppBarApp(),
      'checkmail': (context)=>checkmail(),
      'fakecall': (context)=>fakecall(),
      'home_page': (context)=>home_page()
    },
  ));
}

