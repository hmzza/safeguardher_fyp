import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'fakecall_mainpage.dart';

class ThreatDetect extends StatefulWidget {
  const ThreatDetect({super.key});

  @override
  State<ThreatDetect> createState() => _ThreatDetectState();
}

class _ThreatDetectState extends State<ThreatDetect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText: 'Threat Detection'),
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
          ],
        ));
  }
}
