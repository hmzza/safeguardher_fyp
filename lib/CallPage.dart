import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:safeguardher/fakecall.dart';
import 'package:permission_handler/permission_handler.dart';

class callpage extends StatefulWidget {
  final String name;
  final String areaCode;
  final String prefix;
  final lastFour;
  final String Lang;

  const callpage({
    Key? key,
    required this.name,
    required this.areaCode,
    required this.prefix,
    required this.lastFour,
    required this.Lang,
  }) : super(key: key);

  @override
  State<callpage> createState() => _callpageState();
}

class _callpageState extends State<callpage> {
  Duration duration = Duration();
  Timer? timer;
  bool audioPlaying = false;
  final AudioPlayer player = AudioPlayer();
  bool isSpeakerEnabled = true; // Assume we start with speaker enabled

  @override
  void initState() {
    super.initState();
    startTimer();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _initAudioSession();
    playAudio();
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Initially set to speaker
    await session.setActive(true);
    //await session.setPreferredDevice(AudioDevice.speaker);
  }

  void playAudio() async {
    try {
      await player.setAsset('assets/Audio/maleaudio.mp3');
      await player.play();
      setState(() {
        audioPlaying = true;
      });
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void stopAudio() async {
    await player.stop();
    setState(() {
      audioPlaying = false;
    });
  }

  void toggleSpeaker() async {
    final session = await AudioSession.instance;
    if (isSpeakerEnabled) {
      // Switch to earpiece
      //await session.setPreferredDevice(AudioDevice.earpiece);
    } else {
      // Switch back to speaker
      //await session.setPreferredDevice(AudioDevice.speaker);
    }
    setState(() {
      isSpeakerEnabled = !isSpeakerEnabled;
    });
  }

  void addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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

                height: MediaQuery.of(context).size.height / 5.6,
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
                      GestureDetector(
                        onTap: toggleSpeaker,
                        child: Icon(
                          isSpeakerEnabled ? Icons.volume_up_outlined : Icons.hearing,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

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
              SizedBox(height: 80),
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
                            stopAudio();
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