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
import 'package:safeguardher/fakecall_simulator.dart';
import 'package:safeguardher/forgetpassword.dart';
import 'package:safeguardher/threatDetection_mainPage.dart';
import 'package:safeguardher/utils/mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Check if the route settings have a name and print it
    printCurrentNavigatorStack();
    if (route.settings.name != null) {
      print('Popped screen name: ${route.settings.name}');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    navigator!.widget.pages.forEach((page) {
      print(page);
    });
    super.didPush(route, previousRoute);
    printCurrentNavigatorStack();
  }

  // @override
  // void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
  //   super.didPop(route, previousRoute);
  //   printCurrentNavigatorStack();
  // }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    printCurrentNavigatorStack();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    printCurrentNavigatorStack();
  }

  void printCurrentNavigatorStack() {
    print('Navigator stack:');
    navigator!.widget.pages.forEach((page) {
      print(page);
    });
  }
}


void main() async {
  // Ensure the Flutter engine is initialized before calling Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(MaterialApp(
    navigatorObservers: [MyNavigatorObserver()],
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
      '/fakecall_simulator': (context) => FakeCall_Simulator(),
      '/audio_recorder': (context) => AudioRecorderUploader(),
      '/aboutUs': (context) => AboutUs(),
      '/helplines': (context) => HelpLines(),
      '/editprofile': (context) => EditProfile(),
      '/changepassword': (context) => ChangePwd(),
    },
  ));
}
