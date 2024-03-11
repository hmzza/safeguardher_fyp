import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    _requestPermissionsAndInit();
  }

  Future<void> _requestPermissionsAndInit() async {
    final micStatus = await Permission.microphone.request();
    final storageStatus = await Permission.storage.request();
    if (micStatus != PermissionStatus.granted || storageStatus != PermissionStatus.granted) {
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
      final filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.wav';
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
      var request = http.MultipartRequest('POST', Uri.parse('https://9fbe-115-186-57-250.ngrok-free.app/process'));
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      var response = await request.send();

      final respStr = await response.stream.bytesToString();
      print("DATA:");
      print(jsonDecode(respStr));
      if (response.statusCode == 200) {
        // Assuming the response body contains a JSON object with a boolean field "hateSpeech"
        final decodedResp = jsonDecode(respStr); // Decode the JSON response
        final bool hateSpeechDetected = decodedResp['hateSpeech'] ?? false; // Check for hate speech detection
        print(hateSpeechDetected);
        if (hateSpeechDetected) {
          _timer!.cancel();
          await _audioRecorder.stopRecorder(); // Ensure recording is stopped
          setState(() {
            _response = 'Hate speech detected. Recording stopped.';
          });
        }
      } else {
        setState(() {
          _response = 'Failed to upload audio. Response code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Failed to upload file: $e';
      });
    }
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
                onPressed: _isRecorderInitialized ? _startContinuousRecording : null,
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
              SizedBox(height: 20),
              Text(_response, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}