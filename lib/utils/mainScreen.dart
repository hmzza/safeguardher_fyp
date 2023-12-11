import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/accountsettings.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/helplines.dart';
import 'package:safeguardher/home_page.dart';
import 'package:safeguardher/new_test_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Helplines'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          activeColor: Colors.pink,
        ),
        tabBuilder: (context, index){
          switch(index){
            case 0:
              return CupertinoTabView(
                builder: (context){
                  return CupertinoPageScaffold(child: home_page());
                },
              );

              case 1:
              return CupertinoTabView(
                builder: (context){
                  return CupertinoPageScaffold(child: HelpLines());
                },
              );

              case 2:
              return CupertinoTabView(
                builder: (context){
                  return CupertinoPageScaffold(child: NewTestPage());
                },
              );

              case 3:
              return CupertinoTabView(
                builder: (context){
                  return CupertinoPageScaffold(child: accountsettings());
                },
              );
          }
          return Container();
        }
    );
  }
}
