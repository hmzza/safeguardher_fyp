import 'package:flutter/material.dart';
import 'package:safeguardher/aboutus.dart';
import 'package:safeguardher/accountsettings.dart';
import 'package:safeguardher/changepassword.dart';
import 'package:safeguardher/checkmail.dart';
import 'package:safeguardher/editprofile.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/fakecall_mainpage.dart';
import 'package:safeguardher/helplines.dart';
import 'package:safeguardher/login.dart';
import 'package:safeguardher/signup.dart';
import 'package:safeguardher/forgetpassword.dart';
import 'package:safeguardher/utils/mainScreen.dart';

import 'home_page.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: 'login',
    debugShowCheckedModeBanner: false,
    routes: {
      'login': (context)=>mylogin(),
      'signup': (context)=>SignUp(),
      'forgetpassword': (context)=>AppBarApp(),
      'checkmail': (context)=>checkmail(),
      'fakecall': (context)=>fakecall(),
      'home_page': (context)=>home_page(),
      'main_screen': (context)=>MainScreen(),
      'account_settings': (context)=>accountsettings(),
      'fakecallmainpage': (context)=>fakecallmainpage(),
      'aboutUs': (context)=>AboutUs(),
      'helplines': (context)=>HelpLines(),
      'editprofile': (context)=>EditProfile(),
      'changepassword': (context)=>ChangePwd(),
    },
  ));
}
