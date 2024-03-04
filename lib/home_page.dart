import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/SOSGeneration.dart';
import 'package:safeguardher/accountsettings.dart';
import 'package:safeguardher/fakecall_mainpage.dart';
import 'package:safeguardher/threatDetection_mainPage.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
// import 'package:safeguardher/utils/util.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText: 'Hi Saba!'),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroundlogin.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //THREAT DETECTION ICON
            Positioned(
              child: GestureDetector(
                // or InkWell for ripple effect
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ThreatDetectionMainPage()), // Replace 'YourNewPage' with the actual page you want to navigate to
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/threatdetection.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 108,
                top: 330,
                child: Text(
                  'Threat Detection',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),

            //FAKE CALL SIMULATOR ICON
            Positioned(
              top: 400,
              child: GestureDetector(
                // or InkWell for ripple effect
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            fakecallmainpage()), // Replace 'YourNewPage' with the actual page you want to navigate to
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/fakecall.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 60,
                top: 580,
                child: Text(
                  'Fake Call',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),

            //SOS
            Positioned(
              left: 200,
              top: 400,
              child: GestureDetector(
                // or InkWell for ripple effect
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SOSGeneration()), // Replace 'YourNewPage' with the actual page you want to navigate to
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/sos.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 250,
                top: 580,
                child: Text(
                  'SOS Alert',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ));
  }
}
