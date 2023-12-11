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
    body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/aboutUsBG.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]
    )
    );
  }
}
