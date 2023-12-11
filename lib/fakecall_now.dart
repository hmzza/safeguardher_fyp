import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';

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
  var player;
  bool ringing = false;


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    audioPlayer = AudioPlayer();
    player = AudioPlayer(); // Create a player
    playRingtone();
  }

  void playRingtone() async {
    try {
      final duration = await player.setUrl(
          "asset:assets/Audio/don.mp3"); // Schemes: (https: | file: | asset: )
      // player.play(); // Play without waiting for completion
      await player.play(); // Play while waiting for completion
      // await player.pause(); // Pause but remain ready to play
      // await player
      //     .seek(Duration(seconds: 10)); // Jump to the 10 second position
      // await player.setSpeed(2.0); // Twice as fast
      // await player.setVolume(0.5); // Half as loud
      // await player.stop();
      ringing = true;
    } catch (e) {
      print('Error playing ringtone: $e');
    }
  }

  void stopRingtone() async {

    await player.stop();
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
                           // playRingtone();
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

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
