import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:async';

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
  bool _isRecording = false;
  String _response = 'Press the button to record and upload audio.';
  String? filePath;

  @override
  void initState() {
    super.initState();
    _requestPermissionsAndInit();
    getFileName();
  }

  Future<void> _requestPermissionsAndInit() async {
    print("_requestPermissionsAndInit data");
    var micStatus = await Permission.microphone.request();
    var storageStatus = await Permission.storage.request();
    print(micStatus);
    print(storageStatus);
    if (micStatus != PermissionStatus.granted || storageStatus != PermissionStatus.granted) {
      setState(() {
        _response = 'Microphone or Storage permission not granted';
      });
      return;
    }

    await _initRecorder();
  }

  Future<void> getFileName() async {
    Directory tempDir = await getTemporaryDirectory();
    filePath = '${tempDir.path}/temp.wav';
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

  Future<void> _startRecording() async {

    try {
      await _audioRecorder.startRecorder(toFile: filePath);
      setState(() {
        _isRecording = true;
        _response = 'Recording...';
      });
    } catch (e) {
      setState(() {
        _response = 'Failed to start recording: $e';
      });
    }
  }

  Future<void> _stopRecordingAndUpload() async {
    print("_stopRecordingAndUpload:");
    print(filePath);
    try {
      await _audioRecorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      if (filePath != null) {
        _response = 'Uploading...';
        await _uploadFile(filePath!);
      } else {
        setState(() {
          _response = 'Recording failed, file path is null';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Failed to stop recording: $e';
      });
    }
  }

  Future<void> _uploadFile(String filePath) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://6b5e-115-186-57-250.ngrok-free.app/process_audio')); // Update with your endpoint
      request.files.add(await http.MultipartFile.fromPath('audio', filePath));
      var response = await request.send();

      final respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        setState(() {
          _response = 'Upload successful: $respStr';
        });
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Recorder & Uploader')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isRecorderInitialized && !_isRecording ? _startRecording : null,
              child: Text('Start Recording'),
            ),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecordingAndUpload : null,
              child: Text('Stop and Upload'),
            ),
            SizedBox(height: 20),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
