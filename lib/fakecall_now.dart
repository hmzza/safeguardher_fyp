import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:safeguardher/CallPage.dart';
import 'package:safeguardher/fakecall.dart';

class fakeCallNow extends StatefulWidget {
  final String value;
  const fakeCallNow({Key? key, required this.value}) : super(key: key);

  @override
  State<fakeCallNow> createState() => _fakeCallNowState();
}

class _fakeCallNowState extends State<fakeCallNow>
{
  late String Name = "${widget.value}";
  late AudioPlayer audioPlayer;
  String areaCode = "+92";
  String prefix = "30";
  var lastFour = Random().nextInt(10000000)+9999999;

  var player;
  bool ringing = false;




  @override
  void initState()
  {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    //audioPlayer = AudioPlayer();
    player = AudioPlayer(); // Create a player
    playRingtone();
  }

  void playRingtone() async {
    try {
      final duration = await player.setUrl(
          "asset:assets/Audio/don.mp3");
      await player.play();
      ringing = true;
    } catch (e)
    {
      print('Error playing ringtone: $e');
    }
  }

  void stopRingtone() async
  {
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
                "${widget.value}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
              Text(
                "$areaCode-$prefix$lastFour",
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
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>new fakecall())
                            );
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
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>new callpage(lastFour: lastFour, areaCode: areaCode, prefix: prefix, name: Name ))
                            );
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