import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contacts_service/contacts_service.dart';

class SOSService {
  static final Telephony telephony = Telephony.instance;

  static Future<List<String>> _loadSavedContactNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedContactIds = prefs.getStringList('selectedContacts');
    if (savedContactIds != null && savedContactIds.isNotEmpty) {
      final Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      return contacts
          .where((contact) => savedContactIds.contains(contact.identifier))
          .expand((contact) => contact.phones!.map((phone) => phone.value!))
          .toList();
    }
    return [];
  }

  static Future<void> sendSOSAlert() async {
    List<String> contactNumbers = await _loadSavedContactNumbers();
    final PermissionStatus locationPermissionStatus = await Permission.location.request();
    if (locationPermissionStatus != PermissionStatus.granted) {
      print("Location permission not granted");
      return;
    }

    final Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position == null) {
      print("Failed to get location");
      return;
    }

    final bool? smsPermissionGranted = await telephony.requestSmsPermissions;
    if (!smsPermissionGranted!) {
      print("SMS permission not granted");
      return;
    }

    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
    final String message = "SOS! I need help! Here is my current location: $googleMapsUrl";

    for (String number in contactNumbers) {
      await telephony.sendSms(to: number, message: message);
      // Logging for demonstration
      print("SOS message sent to $number");
    }
  }
}
