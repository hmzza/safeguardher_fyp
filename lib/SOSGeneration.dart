import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:telephony/telephony.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SOSGeneration extends StatefulWidget {
  @override
  _SOSGenerationState createState() => _SOSGenerationState();
}

class _SOSGenerationState extends State<SOSGeneration> with SingleTickerProviderStateMixin {
  final Telephony telephony = Telephony.instance;
  List<String> contactNumbers = [];
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _loadSavedContactNumbers();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _loadSavedContactNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedContactIds = prefs.getStringList('selectedContacts');
    if (savedContactIds != null && savedContactIds.isNotEmpty) {
      final Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      final List<String> numbers = contacts
          .where((contact) => savedContactIds.contains(contact.identifier))
          .expand((contact) => contact.phones!.map((phone) => phone.value!))
          .toList();
      setState(() {
        contactNumbers = numbers;
      });
    }
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
    if (!smsPermissionGranted!) {
      _showSnackbar(context, "SMS permission is required to send SOS messages.");
      return;
    }

    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
    final String message = "SOS! I need help! Here is my current location: $googleMapsUrl";

    for (String number in contactNumbers) {
      await telephony.sendSms(
        to: number,
        message: message,
        statusListener: (SendStatus status){
          if (status == SendStatus.SENT) {
            _showSnackbar(context, "SOS Alert sent to $number.");
          } else if (status == SendStatus.DELIVERED) {
            _showSnackbar(context, "SOS Alert delivered to $number.");
          }
        },
      );
    }
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'SOS'),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundlogin.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    sendSOSAlert();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/sos.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                FadeTransition(opacity: _animationController!,
                 child: Text(
                    "WARNING !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                FadeTransition(
                  opacity: _animationController!,
                  child: Text(
                    "Once you press this button\nSOS will be sent!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
