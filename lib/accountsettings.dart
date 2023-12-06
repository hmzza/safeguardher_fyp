import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class accountsettings extends StatefulWidget {
  const accountsettings({super.key});

  @override
  State<accountsettings> createState() => _accountsettingsState();
}

class _accountsettingsState extends State<accountsettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText: 'Settings'),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/settingsBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

        Container(
          height: 50,
          width: 550,
          margin: EdgeInsets.only(top:100,left: 40,right: 40,bottom: 100),
          decoration: BoxDecoration(
              color: Colors.transparent,
            borderRadius: BorderRadius.circular(100)
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Button color
              // Other style properties
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        )
        ]
    )
    );
  }
}
