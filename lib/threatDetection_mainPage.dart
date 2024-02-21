import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class ThreatDetectionMainPage extends StatefulWidget {
  @override
  _ThreatDetectionMainPageState createState() => _ThreatDetectionMainPageState();
}

class _ThreatDetectionMainPageState extends State<ThreatDetectionMainPage> {
  Interpreter? _interpreter;
  List<String>? _labels;

  @override
  void initState() {
    super.initState();
    loadModel();
    loadLabels();
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/tflite/correct_yamnet.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load the model: $e');
    }
  }

  Future<void> loadLabels() async {
    try {
      final labelList = await rootBundle.loadString('assets/tflite/yamnet_labels.csv');
      final labels = labelList.split('\n');
      setState(() {
        _labels = labels;
      });
    } catch (e) {
      print('Failed to load labels: $e');
    }
  }

  Future<void> classifySound(Float32List soundData) async {
    if (_interpreter == null || _labels == null) {
      print('Interpreter or labels not initialized');
      return;
    }

    // Prepare the input tensor
    Tensor inputTensor = _interpreter!.getInputTensor(0);
    inputTensor.data = soundData as Uint8List;

    // Run the model
    //await _interpreter!.invoke();

    // Fetch the output tensor
    Tensor outputTensor = _interpreter!.getOutputTensor(0);
    Float32List outputData = outputTensor.data as Float32List;

    // Determine the highest probability label index
    int topClassIndex = argMax(outputData);
    String inferredClass = _labels![topClassIndex];

    setState(() {
      print('The main sound is: $inferredClass');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Threat Detection'),
      ),
      body: Center(
        child: Text('Awaiting sound classification...'),
      ),
    );
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}

int argMax(Float32List list) {
  int maxIndex = 0;
  double maxValue = list[0];
  for (int i = 1; i < list.length; i++) {
    if (list[i] > maxValue) {
      maxValue = list[i];
      maxIndex = i;
    }
  }
  return maxIndex;
}