import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/fakecall_simulator.dart';
// import 'package:safeguardher/schedule_fakecall.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

import 'fakecall_incomingcall.dart';

class fakecallmainpage extends StatefulWidget {
  const fakecallmainpage({super.key});

  @override
  State<fakecallmainpage> createState() => _fakecallmainpageState();
}

class _fakecallmainpageState extends State<fakecallmainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText:'Fake Call Simulator'),
    body: Stack(

    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundlogin.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),


      //Call Now

      Positioned(
        left: 100,
        top: 100,
        child: GestureDetector(
          // or InkWell for ripple effect
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new fakecall()),
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(
          left: 160,
          top: 310,
          child: Text(
            'Call Now W',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
      ),




      // schedule late
      Positioned(
        left: 100,
        top: 400,
        child: GestureDetector(
          // or InkWell for ripple effect
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new FakeCall_Simulator()),
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(
          left: 140,
          top: 600,
          child: Text(
            'Schedule Call',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
      ),
      ],
    ),
    );
  }
}
