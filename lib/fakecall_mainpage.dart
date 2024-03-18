import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall.dart';
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
      appBar: CustomAppBar(titleText: 'Fake Call Simulator'),
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
          ListView(
            children: <Widget>[
              SizedBox(height: 40),
              SizedBox(height: 40),
              featureCard(
                label: 'Fake Call Now',
                description: 'Generate fake call instantly',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => fakeCallNow(
                        value: '',
                      )),
                ),
                icon: Icons.call,
              ),
              featureCard(
                label: 'Schedule Fake Call',
                description: 'Generate fake call for later use',
                // Example description
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => fakecallmainpage()),
                ),
                icon: Icons.schedule_outlined,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade600, Color(0xFF7D1DCC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      // Set the font family to Open Sans
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      // Set the font family to Open Sans
                      fontSize: 16,
                      color: Colors.white
                          .withOpacity(0.9), // Slightly transparent white
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
              // Reduced transparency of the icon
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}