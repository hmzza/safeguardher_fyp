import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/accountsettings.dart';
import 'package:safeguardher/home_page.dart';

import '../fakecall_mainpage.dart';

class BasePage extends StatefulWidget {
  // const BasePage({super.key, str});
  final String appBarTitle;
  final bodyStack;

  // Constructor with named parameters
  const BasePage({
    Key? key,
    required this.appBarTitle,
    required this.bodyStack,
  }) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int pageIndex = 0;

  final pages = [
    const home_page(),
    const accountsettings(),
  ];


  // const BasePage(this.appBarTitle, this.bodyStack, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.appBarTitle),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      // body: _pages.elementAt(_selectedIndex),
      body: widget.bodyStack,


    );
    ;
  }
}
























//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Hi, Saba'),
//       backgroundColor: Colors.blueGrey,
//       elevation: 0,
//     ),
//     body: Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/backgroundlogin.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             Column(
//               children: [
//                 Center(
//                   child: Container(
//                       alignment: Alignment.center,
//                       height: 400,
//                       width: 400,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage(
//                                   "assets/images/threatdetection.png"),
//                               fit: BoxFit.cover)),
//                       child: Padding(
//                         padding: EdgeInsets.all(50),
//                         child: Text(
//                           'Yo Hamza my BITCH!!! 2',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )),
//                 ),
//                 Text(
//                   'Yo Hamza my BITCH!!!',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   height: 200,
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.redAccent,
//                     ),
//                     child: const Text('Fake Call'),
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           new MaterialPageRoute(
//                               builder: (context) => new fakecallmainpage()));
//                     },
//                   ),
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/images/fakecall.png"),
//                           fit: BoxFit.cover)),
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   height: 200,
//                   width: 200,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.redAccent,
//                     ),
//                     child: const Text('Login'),
//                     onPressed: () {},
//                   ),
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/images/sos.png"),
//                           fit: BoxFit.cover)),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ],
//     ),
//     bottomNavigationBar: BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.help),
//           label: 'Helplines',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.contact_emergency),
//           label: 'Contacts',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           label: 'Settings',
//         ),
//         // Add other items if you have more than three
//       ],
//       currentIndex: 0,
//       // this will be set when a new tab is tapped
//       onTap: _onItemTapped,
//       selectedItemColor: Colors.amber[800],
//       unselectedItemColor: Colors.grey,
//       // Customize the selected item color
//     ),
//   );;
// }
// }
