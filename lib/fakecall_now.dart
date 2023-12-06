import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class fakeCallNow extends StatefulWidget {
  const fakeCallNow({Key? key}) : super(key: key);

  @override
  State<fakeCallNow> createState() => _fakeCallNowState();
}

class _fakeCallNowState extends State<fakeCallNow> {
  late AudioPlayer audioPlayer;
  Random random = Random();
  String caller = "Abba";
  String areaCode = "+92";
  String prefix = "306";
  String lastFour = "7882240";
  List<String> callerList = [
    "ABBA G",
    "AMMA",
  ];

  bool ringing = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    audioPlayer = AudioPlayer();
    playRingtone();
  }

  void playRingtone() async {
    try {
      final audio = AudioCache();
      audio.loop('ringtone.mp3');
      setState(() {
        ringing = true;
      });
    } catch (e) {
      print('Error playing ringtone: $e');
    }
  }


  void stopRingtone() async {
    if (ringing) {
      await audioPlayer.stop();
      setState(() {
        ringing = false;
      });
    }
  }

  void answerCall() {
    stopRingtone();
    // Add your logic for answering the call here
    // For example, navigate to another screen or perform actions on call acceptance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                caller,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
              Text(
                "$areaCode-$prefix-$lastFour",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.alarm, color: Colors.white, size: 30),
                      Text("Remind Me"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.message, color: Colors.white, size: 30),
                      Text("Message"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: FloatingActionButton(
                          child: Icon(Icons.call_end, size: 34),
                          backgroundColor: Colors.red,
                          onPressed: () {
                            stopRingtone();
                            // Add your logic for declining the call here
                          },
                        ),
                      ),
                      Text("Decline"),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: FloatingActionButton(
                          child: Icon(Icons.phone, size: 34),
                          backgroundColor: Colors.green,
                          onPressed: () {
                            answerCall();
                          },
                        ),
                      ),
                      Text("Accept"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 60),
            ],
          )
        ],
      ),
    );
  }
}

