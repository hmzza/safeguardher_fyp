
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class SOSGeneration extends StatefulWidget {
  @override
  _SOSGenerationState createState() => _SOSGenerationState();
}

class _SOSGenerationState extends State<SOSGeneration> {
  final Telephony telephony = Telephony.instance;
  final List<String> contactNumbers = ['+923067882240', '+923317770723','+923341345552','+923365008261']; // Replace with actual numbers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Alert Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            sendSOSAlert();
          },
          child: Text('Send SOS'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
          ),
        ),
      ),
    );
  }

  void sendSOSAlert() async {
    final PermissionStatus locationPermissionStatus = await _requestLocationPermission();
    if (locationPermissionStatus != PermissionStatus.granted) {
      _showSnackbar(context, "Location permission is required for SOS.");
      return;
    }

    final Position? position = await _determinePosition();
    if (position == null) {
      _showSnackbar(context, "Failed to get the location.");
      return;
    }

    final bool? smsPermissionGranted = await telephony.requestSmsPermissions;
    if (smsPermissionGranted != true) {
      _showSnackbar(context, "SMS permission is required to send SOS messages.");
      return;
    }

    final String message = "SOS! I need help! My location is: Lat: ${position.latitude}, Lng: ${position.longitude}";
    contactNumbers.forEach((number) async {
      await telephony.sendSms(
        to: number,
        message: message,
        statusListener: (SendStatus status) {
          if (status == SendStatus.SENT) {
            _showSnackbar(context, "SOS Alert sent to $number.");
          } else if (status == SendStatus.DELIVERED) {
            _showSnackbar(context, "SOS Alert delivered to $number.");
          }
        },
      );
    });
  }

  Future<Position?> _determinePosition() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<PermissionStatus> _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    return status;
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
