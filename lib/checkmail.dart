import 'package:flutter/material.dart';

class checkmail extends StatefulWidget {
  const checkmail({super.key});

  @override
  State<checkmail> createState() => _checkmailState();
}

class _checkmailState extends State<checkmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          child:  Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/forgetpassword.png")
              ]
          )

      ),
    );
  }
}
