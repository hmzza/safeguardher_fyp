import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/SavedContacts.dart';
import 'package:safeguardher/accountsettings.dart';
import 'package:safeguardher/helplines.dart';
import 'package:safeguardher/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press if necessary or return true to pop
        if (Navigator.of(context).canPop()){
          Navigator.of(context).pop();
        }
        return false;
      },
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.question_circle), label: 'Helplines'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_2_square_stack), label: 'Contacts'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.gear), label: 'Settings'),
          ],
          activeColor: Colors.pink,
          backgroundColor: Colors.black,
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoPageScaffold(child: home_page());
            case 1:
              return CupertinoPageScaffold(child: HelpLines());
            case 2:
              return CupertinoPageScaffold(child: SavedContacts());
            case 3:
              return CupertinoPageScaffold(child: AccountSettings());
            default:
              return Container();
          }
        },
      ),
    );
  }
}