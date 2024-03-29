import 'dart:async';

// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguardher/services/sos_service.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vibration/vibration.dart';

typedef _Fn = void Function();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AudioRecorderUploader(),
    );
  }
}

class AudioRecorderUploader extends StatefulWidget {
  @override
  _AudioRecorderUploaderState createState() => _AudioRecorderUploaderState();
}

class _AudioRecorderUploaderState extends State<AudioRecorderUploader> {
  bool _isRecording = false;
  int countdown = 7; // Initialize countdown duration
  Timer? countdownTimer;
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  String _response = 'Press the button to start continuous recording.';
  Timer? _timer;

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;

  @override
  void initState() {
    super.initState();
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    _requestPermissionsAndInit();
  }

  Future<void> _requestPermissionsAndInit() async {
    final micStatus = await Permission.microphone.request();
    final storageStatus = await Permission.storage.request();
    if (micStatus != PermissionStatus.granted ||
        storageStatus != PermissionStatus.granted) {
      setState(() {
        _response = 'Microphone or Storage permission not granted';
      });
      return;
    }
    await _initRecorder();
  }

  Future<void> _initRecorder() async {
    try {
      await _audioRecorder.openRecorder();
      _audioRecorder.setSubscriptionDuration(const Duration(milliseconds: 500));
      setState(() {
        _isRecorderInitialized = true;
      });
    } catch (e) {
      setState(() {
        _response = 'Failed to initialize recorder: $e';
      });
    }
  }

  // void play() {
  //   // print("PLayer path: $completePath");
  //   // assert(_mPlayerIsInited &&
  //   //     _mplaybackReady &&
  //   //     _mRecorder!.isStopped &&
  //   //     _mPlayer!.isStopped);
  //   _mPlayer!
  //       .startPlayer(
  //           fromURI: filePath,
  //           codec: Codec.defaultCodec,
  //           whenFinished: () {
  //             setState(() {});
  //           })
  //       .then((value) {
  //     setState(() {});
  //   });
  // }

  void _startContinuousRecording() async {
    if (!_isRecorderInitialized) return;
    setState(() {
      _response = 'Recording started...';
      _isRecording = true;
    });

    const chunkDuration = Duration(seconds: 10);

    // Function to handle recording logic
    Future<void> _recordChunk() async {
      print("Timer Starting");
      final tempDir = await getTemporaryDirectory();
      String filePath =
          '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.wav';
      await _audioRecorder.startRecorder(toFile: filePath);
      await Future.delayed(chunkDuration); // Wait for 15 seconds
      await _audioRecorder.stopRecorder();
      print("Timer Ending");
      await _uploadFile(filePath);
    }

    // Start recording immediately
    await _recordChunk();

    // Then continue recording every 15 seconds
    _timer = Timer.periodic(chunkDuration, (timer) async {
      await _recordChunk();
    });
  }

  Future<void> _stopRecording() async {
    _timer!.cancel();
    _timer = null;
    await _audioRecorder.stopRecorder();
    setState(() {
      _response = 'Recording stopped.';
      _isRecording = false;
    });
  }

  Future<void> _uploadFile(String filePath) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://13.53.61.151:8080/threat'));
      request.files.add(await http.MultipartFile.fromPath('audio', filePath));
      print("Uploading data to server");
      var response = await request.send();
      print("Response received");
      print(response);
      final respStr = await response.stream.bytesToString();
      Map<String, dynamic> decodedResp = jsonDecode(respStr);
      Map<String, dynamic> trimmedResp = decodedResp.map((key, value) {
        return MapEntry(key.trim(), value is String ? value.trim() : value);
      });
      print(trimmedResp);
      if (response.statusCode == 200) {
        final bool threatDetected =
            trimmedResp['Threat'].toString().toLowerCase() == 'true';
        print(threatDetected);
        print(decodedResp);
        if (threatDetected) {
          _timer?.cancel();
          await _audioRecorder.stopRecorder(); // Ensure recording is stopped
          setState(() {
            _response = 'Threat detected. Recording stopped.';
            _showThreatDetectedDialog(); // Show the dialog
          });
        }
      } else {
        setState(() {
          _response =
              'Failed to upload audio. Response code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Failed to upload file: $e';
      });
    }
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  // _Fn? getPlaybackFn() {
  //   return _mPlayer!.isStopped ? play : stopPlayer;
  // }
  void _playSOSAlertSentSound() async {
    final player = FlutterSoundPlayer();
    try {
      await player.openPlayer();
      final ByteData data =
          await rootBundle.load('assets/Audio/alert_sound_sos_sent.mp3');
      final buffer = data.buffer.asUint8List();

      // The following line assumes startPlayer is available and accepts a Uint8List
      await player.startPlayer(fromDataBuffer: buffer, codec: Codec.mp3);
      player.setVolume(1.0);

      // If playerSubscription is not available, you may need to listen to the player's stream
      // For example:
      // player.onPlayerStateChanged.listen((event) {
      //   if (event == PlayerState.STOPPED) {
      //     // Handle the end of playback
      //   }
      // });
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  void dispose() {
    // Close the recorder and player
    _audioRecorder.closeRecorder();
    _mPlayer?.closePlayer();
    countdownTimer?.cancel();

    // Cancel the timer if it's active
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    super.dispose();
  }

  void _showThreatDetectedDialog() {
    // Start vibrating when the dialog is shown
    Vibration.vibrate(duration: 7000);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ThreatDetectedDialog(
          onCountdownCompleted: () {
            _sendSOSMessage(); // This will be called when the countdown finishes
          },
        );
      },
    );
  }

  void _sendSOSMessage() async {
    // Stop the recording if it's still running
    if (_timer != null && _timer!.isActive) {
      await _stopRecording();
    }

    // Call the SOS service to send out the alert
    await SOSService.sendSOSAlert();
    _playSOSAlertSentSound();
    // Show the SOS sent dialog
    _showSOSGeneratedDialog();
  }

  void _showSOSGeneratedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("SOS Sent!"),
          content: Text("Your SOS message has been sent successfully."),
          actions: <Widget>[
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Threat Detector'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundlogin.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0),
                // Adjust the padding as needed
                child: Column(
                  children: [
                    Text(
                      "Let us protect!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        // Adjust the font size as needed
                        fontWeight: FontWeight.bold,
                        // Use bold font weight for emphasis
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "We are here for you",
                      style: TextStyle(
                        color: Colors.white70,
                        // Slightly transparent white
                        fontSize: 22.0,
                        // Adjust the font size as needed
                        fontStyle: FontStyle.italic,
                        // Use italic font style for subtlety
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: _isRecorderInitialized
                    ? (_isRecording
                        ? _stopRecording
                        : _startContinuousRecording)
                    : null,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Makes the container circular
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        // Shadow color with some transparency
                        spreadRadius: 2,
                        // Spread radius
                        blurRadius: 10,
                        // Blur radius
                        offset: Offset(0,
                            5), // The X,Y offset of the shadow from the widget
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // Ensures the image has a circular shape
                    child: Image.asset(
                      _isRecording
                          ? 'assets/images/mic_logo_on_green.png'
                          : 'assets/images/mic_logo.png',
                      // Choose the image based on recording status
                      width: 300,
                      height: 300,
                      fit: BoxFit
                          .cover, // Ensures the image covers the ClipOval area
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _stopRecording(),
                child: Text(
                  'Stop Recording',
                  style: TextStyle(color: Colors.red),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
              SizedBox(height: 20),
              // Row(children: [
              //   ElevatedButton(
              //     onPressed: getPlaybackFn(),
              //     //color: Colors.white,
              //     //disabledColor: Colors.grey,
              //     child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
              //   ),
              //   SizedBox(
              //     width: 20,
              //   ),
              //   Text(_mPlayer!.isPlaying
              //       ? 'Playback in progress'
              //       : 'Player is stopped'),
              // ]),
              // Here the server response is shown on the screen
              Text(
                _response,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  backgroundColor: Colors.black.withOpacity(
                      0.5), // Add a semi-transparent background for better readability
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThreatDetectedDialog extends StatefulWidget {
  final Function onCountdownCompleted;

  ThreatDetectedDialog({required this.onCountdownCompleted});

  @override
  _ThreatDetectedDialogState createState() => _ThreatDetectedDialogState();
}

class _ThreatDetectedDialogState extends State<ThreatDetectedDialog> {
  int countdown = 7;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        countdownTimer?.cancel();
        widget.onCountdownCompleted();
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Threat Detected!", style: TextStyle(color: Colors.red)),
      content: Text(
          "Are you safe? If you don't select Yes, SOS will be sent in $countdown seconds", style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        TextButton(
          child: Text("Yes", style: TextStyle(color: Colors.green)),
          onPressed: () {
            countdownTimer?.cancel();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("No", style: TextStyle(color: Colors.black)),
          onPressed: () {
            countdownTimer?.cancel();
            Navigator.of(context).pop();
            widget.onCountdownCompleted();
          },
        ),
      ],
    );
  }
}
