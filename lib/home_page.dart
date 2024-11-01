import 'package:flutter/material.dart';
import 'package:safeguardher/SOSGeneration.dart';
import 'package:safeguardher/accountsettings.dart';

// import 'package:safeguardher/fakecall.dart';
import 'package:safeguardher/threatDetection_mainPage.dart';
import 'package:safeguardher/utils/carousel_cards.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

import 'fakecall_simulator.dart';
import 'helplines.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xff48032f),
        title: Text('SafeGuardHer', style: TextStyle(color: Colors.white)),
        leading: Padding(
          padding: EdgeInsets.all(8.0), // Adjust padding as needed
          child: Image.asset(
              'assets/images/logo.png'), // Replace with your logo asset path
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AccountSettings(), // Replace with your settings page class
              ));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/darkbgwithfade.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 40),
              CarouselCards(),
              SizedBox(height: 40),
              featureCard(
                label: 'Threat Detection',
                description: 'Monitor and alert in real-time',
                // Example description
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AudioRecorderUploader()),
                ),
                icon: Icons.security,
              ),
              featureCard(
                label: 'Fake Call',
                description: 'Simulate calls to avoid danger',
                // Example description
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FakeCall_Simulator()),
                ),
                icon: Icons.phone_in_talk,
              ),
              featureCard(
                label: 'SOS Alert',
                description: 'Send your location to contacts',
                // Example description
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SOSGeneration()),
                ),
                icon: Icons.add_alert,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget featureCard({
    required String label,
    required String description,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          // Use Ink for the gradient and keep the ripple effect
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB44E85), Color(0xFFB44E85)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5), // Adjust spacing as needed
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
