import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:safeguardher/CallPage.dart';
import 'package:safeguardher/fakecall_simulator.dart';

class fakeCallNow extends StatefulWidget {
  final String value;
  final String? selectedGender;
  final String? selectedLang;

  const fakeCallNow(
      {Key? key,
      required this.value,
      required this.selectedGender,
      required this.selectedLang})
      : super(key: key);

  @override
  State<fakeCallNow> createState() => _fakeCallNowState();
}

class _fakeCallNowState extends State<fakeCallNow> {
  late String selectedLang = "${widget.selectedLang}";
  late String Name = "${widget.value}";
  late String gender = "${widget.selectedGender}";
  late AudioPlayer audioPlayer;
  String areaCode = "+92";
  String prefix = "30";
  var LastFour = Random().nextInt(10000000) + 9999999;

  var player;
  bool ringing = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    audioPlayer = AudioPlayer(); // Initialize the audio player
    playRingtone(); // Call this method to play the ringtone
  }

  void playRingtone() async {
    try {
      await audioPlayer.setAsset('assets/Audio/ringtone.mp3'); // Make sure this is the correct path to your audio asset
      await audioPlayer.play();
      print("Playing audio");// Play the audio
    } catch (e) {
      print("Could not load the audio: $e");
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Dispose of the player when the widget is disposed
    super.dispose();
  }

  void stopRingtone() async {
    await audioPlayer.stop();
    setState(() {
      ringing = false;
    });
  }

  void answerCall() {
    stopRingtone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "${widget.value}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                  color: Colors.white),
              ),
              Text(
                "$areaCode-$prefix$LastFour",
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
              SizedBox(height: 60),
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
                            int count = 0;
                            //route theek karraha
                            Navigator.of(context).popUntil((_) => count++ >= 1);
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new callpage(
                                          name: Name,
                                          genderSelection: gender,
                                          areaCode: areaCode,
                                          prefix: prefix,
                                        lastFour: LastFour,
                                          Lang: selectedLang,
                                        )));
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
