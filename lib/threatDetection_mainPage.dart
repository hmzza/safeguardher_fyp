import 'dart:async';

// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'dart:convert';

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
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  String _response = 'Press the button to start continuous recording.';
  late Timer? _timer;

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  String filePath = "";

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

  void play() {
    // print("PLayer path: $completePath");
    // assert(_mPlayerIsInited &&
    //     _mplaybackReady &&
    //     _mRecorder!.isStopped &&
    //     _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        fromURI: filePath,
        codec: Codec.defaultCodec,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      setState(() {});
    });
  }

  void _startContinuousRecording() async {
    if (!_isRecorderInitialized) return;
    setState(() {
      _response = 'Recording started...';
    });

    const chunkDuration = Duration(seconds: 15);

    // Function to handle recording logic
    Future<void> _recordChunk() async {
      print("Timer Starting");
      final tempDir = await getTemporaryDirectory();
      filePath =
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
      print(respStr);
      final decodedResp = jsonDecode(respStr); // Decode the JSON response
      if (response.statusCode == 200) {
        final bool threatDetected =
            decodedResp['threat'].toString().toLowerCase() == 'true';
        print(threatDetected);
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

  void _showThreatDetectedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Threat Detected!"),
          content: Text("Are you safe?"),
          actions: <Widget>[
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                // Handle the user's response accordingly
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed: () {
                // Handle the user's response accordingly
                // For example, you might call a method to send for help or an SOS
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }
  _Fn? getPlaybackFn() {

    return _mPlayer!.isStopped ? play : stopPlayer;
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    _timer!.cancel();
    super.dispose();
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
              ElevatedButton(
                onPressed:
                    _isRecorderInitialized ? _startContinuousRecording : null,
                child: Text('Start Continuous Recording'),
              ),
              ElevatedButton(
                onPressed: () => _stopRecording(),
                child: Text(
                  'Stop Recording',
                  style: TextStyle(color: Colors.white),
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
