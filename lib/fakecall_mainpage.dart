import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/schedule_fakecall.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

import 'fakecall_now.dart';

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
      Container(
       //color: Colors.grey,
        width: 380,
        height: 250,
        margin: EdgeInsets.only(top: 80,left: 60,right: 60),
          child:ElevatedButton(
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                  new fakecall())
              );
            },
            child: Container(
              //color: Colors.white,
                height: 50,
                width: 200,
                margin: EdgeInsets.only(left: 10),
                child: Center(
                    child: Text('Call Now',style: TextStyle(fontSize: 25, color: Colors.black),)
                )
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.blue, // <-- Button color
              //foregroundColor: Colors.white, // <-- Splash color
            ),
          ),

      ),
      Container(
        //color: Colors.grey,
        width: 380,
        height: 250,
        margin: EdgeInsets.only(top:400,left: 60,right: 60),
        child:ElevatedButton(
          onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) =>
                new fakeCallNow(value: '',))
            );

          },
          child: Container(
              //color: Colors.white,
              height: 50,
              width: 200,
              margin: EdgeInsets.only(left: 10),
              child: Center(
                  child: Text('Schedule Later',style: TextStyle(fontSize: 25, color: Colors.black),)
              )
          ),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),

            padding: EdgeInsets.all(10),
            backgroundColor: Colors.blue, // <-- Button color
            //foregroundColor: Colors.white, // <-- Splash color
          ),
        ),

      ),

      ],
    ),
    );
  }
}
