// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class SimpleRecorder extends StatefulWidget {
  const SimpleRecorder({super.key});

  @override
  State<SimpleRecorder> createState() => _SimpleRecorderState();
}
typedef _Fn = void Function();
const theSource = AudioSource.microphone;
var uuid = const Uuid();

class _SimpleRecorderState extends State<SimpleRecorder> {
  Codec _codec = Codec.defaultCodec;
  String _mPath = '${uuid.v4()}.wav';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  dynamic directory = "";

  String completePath = "";
  String directoryPath = "";

  String _completePath(String directory) {
    _mPath = '${uuid.v4()}.wav';
    var fileName = _mPath;
    return "$directory$fileName";
  }

  String _directoryPath() {
    var directoryPath = directory!.path;
    return "$directoryPath/records/";
  }

  @override
  void initState() {
    _mPlayer!.openPlayer().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
    print("Before super init");
    _initDirectory();
    print("After super init");
  }

  bool _isRecorderInitialised = false;

  Future _createFile() async {
    File(completePath).create(recursive: true).then((File file) async {
      //write to file
      Uint8List bytes = await file.readAsBytes();
      file.writeAsBytes(bytes);
      print("FILE CREATED AT : " + file.path);
    });
  }

  void _createDirectory() async {
    bool isDirectoryCreated = await Directory(directoryPath).exists();
    if (!isDirectoryCreated) {
      Directory(directoryPath).create().then((Directory directory) {
        print("DIRECTORY CREATED AT : " + directory.path);
      });
    }
  }

  void _initPaths() {
    directoryPath = _directoryPath();
    completePath = _completePath(directoryPath);
    _createDirectory();
    _createFile();
    _isRecorderInitialised = true;
    setState(() {});
  }

  Future<void> _initDirectory() async {
    directory = await getExternalStorageDirectory();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openRecorder();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.defaultCodec;
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));

    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    print("Before record path: $completePath");
    _initPaths();
    print("After record path: $completePath");
    _mRecorder!
        .startRecorder(
      toFile: completePath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      // File f = File(value!);
      // print("The created file : $f");
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    print("PLayer path: $completePath");
    // assert(_mPlayerIsInited &&
    //     _mplaybackReady &&
    //     _mRecorder!.isStopped &&
    //     _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        fromURI: completePath,
        codec: Codec.defaultCodec,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
  }
  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getRecorderFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mRecorder!.isRecording ? 'Stop' : 'Record'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mRecorder!.isRecording
                  ? 'Recording in progress'
                  : 'Recorder is stopped'),
            ]),
          ),
          Container(
            // Image.asset('assets/images/backgroundLoginPage.png')
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: getPlaybackFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(_mPlayer!.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(_mPlayer!.isPlaying
                  ? 'Playback in progress'
                  : 'Player is stopped'),
            ]),
          ),
        ],
      );
    }
    return Scaffold(
        appBar: CustomAppBar(titleText:'Simple Recorder'),
      body: Stack(
        children: <Widget>[
          // The background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgroundLoginPage.png',
              fit: BoxFit.cover,
            ),
          ),
          // The actual body content
          makeBody(),
        ],
      ),
    );
  }
}
