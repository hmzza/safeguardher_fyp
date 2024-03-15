import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/schedule_fakecall.dart';
// import 'package:safeguardher/schedule_fakecall.dart';
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
            'Call Now',
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
                      new ScheduleFakeCall()),
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



      //
      //
      //
      // Container(
      //  //color: Colors.grey,
      //   width: 300,
      //   height: 120,
      //   margin: EdgeInsets.only(top: 280,left: 60,right: 60),
      //     child:ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(context, new MaterialPageRoute(
      //             builder: (context) =>
      //             new fakeCallNow(value: '',))
      //         );
      //       },
      //       child: Container(
      //         //color: Colors.white,
      //           height: 50,
      //           width: 200,
      //           margin: EdgeInsets.only(left: 10),
      //           child: Center(
      //               child: Text('Call Now',style: TextStyle(fontSize: 20, color: Colors.black),)
      //           )
      //       ),
      //       style: ElevatedButton.styleFrom(
      //         shape: const RoundedRectangleBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(50)),
      //         ),
      //         padding: EdgeInsets.all(10),
      //         backgroundColor: Colors.blue, // <-- Button color
      //         //foregroundColor: Colors.white, // <-- Splash color
      //       ),
      //     ),
      //
      // ),
      //
      //
      //
      //
      //
      //
      // //Schedule Later
      // Container(
      //   //color: Colors.grey,
      //   width: 300,
      //   height: 120,
      //   margin: EdgeInsets.only(top:500,left: 60,right: 60),
      //   child:ElevatedButton(
      //     onPressed: () {
      //       Navigator.push(context, new MaterialPageRoute(
      //           builder: (context) =>
      //           new fakeCallNow(value: '',))
      //       );
      //     },
      //     child: Container(
      //         //color: Colors.white,
      //         height: 50,
      //         width: 200,
      //         margin: EdgeInsets.only(left: 10),
      //         child: Center(
      //             child: Text('Schedule Later',style: TextStyle(fontSize: 20, color: Colors.black),)
      //         )
      //     ),
      //     style: ElevatedButton.styleFrom(
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(50)),
      //       ),
      //
      //       padding: EdgeInsets.all(10),
      //       backgroundColor: Colors.blue, // <-- Button color
      //       //foregroundColor: Colors.white, // <-- Splash color
      //     ),
      //   ),
      //
      // ),
      //




      ],
    ),
    );
  }
}
