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
import 'package:safeguardher/simple_recorder.dart';
import 'package:safeguardher/signup.dart';
import 'package:safeguardher/forgetpassword.dart';
import 'package:safeguardher/threatDetection_mainPage.dart';
import 'package:safeguardher/utils/mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async {
  // Ensure the Flutter engine is initialized before calling Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(MaterialApp(
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => mylogin(),
      '/simple_recorder': (context) => SimpleRecorder(),
      '/signup': (context) => SignUp(),
      '/forgetpassword': (context) => AppBarApp(),
      '/checkmail': (context) => checkmail(),
      '/fakecall': (context) => fakecall(),
      '/home_page': (context) => home_page(),
      '/main_screen': (context) => MainScreen(),
      '/account_settings': (context) => AccountSettings(),
      '/fakecallmainpage': (context) => fakecallmainpage(),
      '/audio_recorder': (context) => AudioRecorderUploader(),
      '/aboutUs': (context) => AboutUs(),
      '/helplines': (context) => HelpLines(),
      '/editprofile': (context) => EditProfile(),
      '/changepassword': (context) => ChangePwd(),
    },
  ));
}
