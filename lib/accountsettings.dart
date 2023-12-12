import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeguardher/aboutus.dart';
import 'package:safeguardher/changepassword.dart';
import 'package:safeguardher/editprofile.dart';
import 'package:safeguardher/helpandsupport.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:safeguardher/utils/imageprovider.dart';
// import 'package:safeguardher/utils/imageprovider.dart';

class accountsettings extends StatefulWidget {
  const accountsettings({super.key});

  @override
  State<accountsettings> createState() => _accountsettingsState();
}

class _accountsettingsState extends State<accountsettings> {
  Uint8List? _image;
  double temp = 350;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(titleText: 'Settings'),
        body: Stack(children: <Widget>[
          //background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/settingsBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Profile picture
          _image != null
              ? Positioned(
              left: 20,
              top: 20,
                  child: CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                ))
              :
          Positioned(
                  left: 20,
                  top: 20,
                  child: const CircleAvatar(
                    radius: 64,
                    backgroundImage:
                        AssetImage('assets/images/profile_placeholder.jpg'),
                  ),
                ),
          Positioned(
            top: 110,
            left: 110,
            child: IconButton(
              onPressed: selectImage,
              icon: const Icon(Icons.add_a_photo),
              color: Colors.white,
            ),
          ),
          //User's Name
          Positioned(
            top: 170,
            left: 25,
            child: Container(
              height: 50,
              width: 550,
              // margin: EdgeInsets.only(top: 40, left: 35, right: 35, bottom: 100),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  'Saba Karim',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          //Divider
          Positioned(
            top: 210,
            child: Container(
              height: 50,
              width: 550,
              // margin: EdgeInsets.only(top: 40, left: 35, right: 35, bottom: 100),
              color: Colors.transparent,
              child: Divider(
                height: 5,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.white,
              ),
            ),
          ),
          //Account heading
          Positioned(
            top: 230,
            left: 25,
            child: Container(
              height: 50,
              width: 550,
              // margin: EdgeInsets.only(top: 40, left: 35, right: 35, bottom: 100),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  'Account',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          //Account Options
          Positioned(
              left: 30,
              top: 300,
              child: Container(
                // margin: EdgeInsets.only(top: 140, left: 30, right: 30, bottom: 0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),

                  children: [
                    // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
                    Container(
                      height: 50,

                      width: temp,

                      // margin: EdgeInsets.only(top: 100, left: 35, right: 35, bottom: 100),

                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                              new EditProfile())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          backgroundColor: Colors.white, // Button color

                          // Other style properties
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Edit Profile',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,

                      width: temp,

                      // margin: EdgeInsets.only(top: 180, left: 35, right: 35, bottom: 100),

                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                              new ChangePwd())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          backgroundColor: Colors.white, // Button color

                          // Other style properties
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Change your Password',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,

                      width: temp,

                      // margin: EdgeInsets.only(top: 260, left: 35, right: 35, bottom: 100),

                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),

                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          backgroundColor: Colors.white, // Button color

                          // Other style properties
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Guide (User Manual)',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,

                      width: temp,

                      // margin: EdgeInsets.only(top: 340, left: 35, right: 35, bottom: 100),

                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                              new HelpAndSupport())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          backgroundColor: Colors.white, // Button color

                          // Other style properties
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'Help & Support',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,

                      width: temp,

                      // margin: EdgeInsets.only(top: 420, left: 35, right: 35, bottom: 100),

                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                              new AboutUs())
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          backgroundColor: Colors.white, // Button color

                          // Other style properties
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'About Us',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    //LOGOUT BUTTON
                    Container(
                      height: 50,
                      width: 100,

                      // margin: EdgeInsets.only(top: 420, left: 35, right: 35, bottom: 100),

                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)),

                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                          backgroundColor: Colors.red, // Button color

                          // Other style properties
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              'LOGOUT',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))

          //bars
        ]));
  }
}
