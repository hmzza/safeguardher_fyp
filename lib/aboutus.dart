import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText: 'About Us'),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/aboutUsBG.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 300,
              left: 40,
              child: Container(
                width: 330,
                height: 350,
                child: Align(
                  child: Text(
                    'The motivation behind SafeGuardHER is to address safety concerns for women during public transportation and ride-sharing journeys. '
                    'Manual activation of existing safety apps can be impractical in emergencies, '
                    'and individuals may not have the presence of mind to use them. '
                    'SafeGuardHER aims to empower women by providing an automated, '
                    'real-time safety solution that proactively detects and responds to threats, '
                    'utilizing technology-driven solutions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ))
        ]));
  }
}
