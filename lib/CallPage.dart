import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall.dart';

class callpage extends StatefulWidget {

  var name;
  var areaCode;
  var prefix;
  var lastFour;

   callpage({Key? key, required this.lastFour, required this.areaCode, required this.prefix, required this.name}) : super(key: key);

  @override
  State<callpage> createState() => _callpageState();

}

class _callpageState extends State<callpage> {
  Duration duration = Duration();
  Timer? timer;

  @override
 void initState() {
    super.initState();

    startTimer();
  }

  void addTime() {

    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
        }
  void startTimer()
  {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade900,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "${widget.name}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
              Text(
                "${widget.areaCode}${widget.prefix}${widget.lastFour}",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      buildTime(),
                    ],
                  )
                ],
              ),
              SizedBox(

                height: MediaQuery.of(context).size.height / 5.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.mic_off, color: Colors.white, size: 32),
                      Text("Mute"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.keyboard_alt_outlined, color: Colors.white, size: 32),
                      Text("keypad"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.volume_up_outlined, color: Colors.white, size: 32),
                      Text("Speaker"),
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
                      Icon(Icons.add_call, color: Colors.white, size: 32),
                      Text("Mute"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.video_call_outlined, color: Colors.white, size: 32),
                      Text("keypad"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.pause, color: Colors.white, size: 32),
                      Text("Hold"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 160),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: FloatingActionButton(
                          child: Icon(Icons.call_end, size: 37),
                          backgroundColor: Colors.red,
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>new fakecall())
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 140),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: 20),
    );
  }
}