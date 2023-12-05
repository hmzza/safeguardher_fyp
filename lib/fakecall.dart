import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class fakecall extends StatefulWidget {
  const fakecall({super.key});

  @override
  State<fakecall> createState() => _fakecallState();
}

class _fakecallState extends State<fakecall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(child: Text('Play'),
            onPressed: () {
              final player = AudioCache();
              // player.play('fakecall.mp3');
            },
          ),
        ),
      ), // ElevatedButton
    );
  }}




//
// child: Container(
// child: Column(
// // mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// //THREAT DETECTION
// // SizedBox(
// //   height: 100,
// // ),
// Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// TextButton(
// onPressed: () => {},
// child: Column( // Replace with a Row for horizontal icon + text
// children: <Widget>[
// Icon(Icons.add),
// Text("Add")
// ],
// ),
// ),
// ],
// ),
// ),
// Text('Threat Detection', style: TextStyle(color: Colors.white),),
//
// // SizedBox(height: 20), // Provide some spacing
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
//
// children: <Widget>[
// IconButton(
// icon: Image.asset('assets/images/fakecall.png'),
// iconSize: 180,
// onPressed: () {
// // Handle Fake Call Simulator action
// },
// ),
// IconButton(
// icon: Image.asset('assets/images/sos.png'),
// iconSize: 180,
// onPressed: () {
// // Handle Send SOS action
// },
// ),
// ],
// ),
// ],
// ),
// ),