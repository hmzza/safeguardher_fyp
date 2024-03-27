import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguardher/utils/custom_app_bar.dart'; // Ensure you have this custom app bar in your project
import 'package:telephony/telephony.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSGeneration extends StatefulWidget {
  @override
  SOSGenerationState2 createState() => SOSGenerationState2();

}

class SOSGenerationState2 extends State<SOSGeneration>
    with SingleTickerProviderStateMixin {
  final Telephony telephony = Telephony.instance;
  List<String> contactNumbers = [];
  AnimationController? _animationController;
  Color _warningTextColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadSavedContactNumbers();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _loadSavedContactNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedContactIds =
        prefs.getStringList('selectedContacts');
    if (savedContactIds != null && savedContactIds.isNotEmpty) {
      final Iterable<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      final List<String> numbers = contacts
          .where((contact) => savedContactIds.contains(contact.identifier))
          .expand((contact) => contact.phones!.map((phone) => phone.value!))
          .toList();
      setState(() {
        contactNumbers = numbers;
      });
    }
  }

  Future<Position?> _determinePosition() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<PermissionStatus> _requestLocationPermission() async {
    return await Permission.location.request();
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void sendSOSAlert() async {
    final PermissionStatus locationPermissionStatus =
        await _requestLocationPermission();
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
      _showSnackbar(
          context, "SMS permission is required to send SOS messages.");
      return;
    }

    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
    final String message =
        "SOS! I need help! Here is my current location: $googleMapsUrl";

    for (String number in contactNumbers) {
      await telephony.sendSms(
        to: number,
        message: message,
        statusListener: (SendStatus status) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (status == SendStatus.SENT) {
              _showSnackbar(context, "SOS Alert sent to $number.");
            } else if (status == SendStatus.DELIVERED) {
              _showSnackbar(context, "SOS Alert delivered to $number.");
            }
          });
        },
      );
    }
    _showSOSGeneratedDialog();
  }

  void sendSOSWhatsApp() async {
    final Position? position = await _determinePosition();
    if (position == null) {
      _showSnackbar(context, "Failed to get the location.");
      return;
    }

    String message =
        "SOS! I need help! Here is my current location: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";

    // Retrieve custom contacts from shared preferences or another source
    final List<String> whatsappNumbers =
        contactNumbers; // replace with your contact numbers list

    print("+============================================");
    print(whatsappNumbers);

    for (var number in whatsappNumbers) {
      // Ensure the phone number is in international format and url encoded
      final Uri whatsappUrl = Uri(
        scheme: 'https',
        host: 'api.whatsapp.com',
        path: '/send',
        queryParameters: {
          'phone': number, // Include country code
          'text': message,
        },
      );

      // Open the WhatsApp URL
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
        // Break the loop after opening the URL for the first number
        break;
      } else {
        _showSnackbar(context,
            "WhatsApp is not installed or not available for the number $number.");
      }
    }
  }

  void _onSOSPressed() async {
    setState(() {
      _warningTextColor = Colors.red;
    });

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1500); // Vibrate for 500 milliseconds
    }

    sendSOSAlert();

    Timer(Duration(seconds: 10), () {
      setState(() {
        _warningTextColor = Colors.white;
      });
    });
  }

  void _showSOSGeneratedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("SOS Generated!"),
          content: Text("Your SOS message has been sent."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'SOS'),
      // Make sure this matches your custom app bar
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
                Text(
                  "WARNING !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _warningTextColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // Color of the shadow
                        spreadRadius: 1,
                        // Spread radius
                        blurRadius: 10,
                        // Blur radius
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent, // Set the color to transparent
                      child: InkWell(
                        splashColor: Colors.red.withOpacity(0.3),
                        // Splash color over the image
                        onTap: _onSOSPressed,
                        // Trigger SOS function when image is tapped
                        child: Ink.image(
                          image: AssetImage('assets/images/sos.png'),
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: sendSOSWhatsApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x910B9801), // WhatsApp color
                  ),
                  child: Text('Send SOS through WhatsApp', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
