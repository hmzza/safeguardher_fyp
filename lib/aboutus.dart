import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(titleText: 'About Us'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/darkbgwithfade.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.05),
              Text(
                'SafeGuardHER',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                  
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Motivation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xE5F15C94),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'The motivation behind SafeGuardHER is to address safety concerns for women during public transportation and ride-sharing journeys. Manual activation of existing safety apps can be impractical in emergencies, and individuals may not have the presence of mind to use them. SafeGuardHER aims to empower women by providing an automated, real-time safety solution that proactively detects and responds to threats, utilizing technology-driven solutions.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Icon(Icons.security, color:  Color(0xFFF54184), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Security at Your Fingertips',
                    style: TextStyle(fontSize: 20, color:  Color(0xE5F15C94), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'With SafeGuardHER, security is not just a concept, but a reality that you carry with you. Our innovative features ensure that help is always just a tap away, making safety more accessible than ever before.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              // Additional sections can be added here
            ],
          ),
        ),
      ),
    );
  }
}
