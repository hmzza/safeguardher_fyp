import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLines extends StatefulWidget {
  const HelpLines({Key? key}) : super(key: key);

  @override
  State<HelpLines> createState() => _HelpLinesState();
}

class _HelpLinesState extends State<HelpLines> {
  String selectedCity = 'Islamabad'; // Default value for the dropdown

  // Dummy data for the list of helplines by city
  final Map<String, List<Map<String, String>>> cityHelplines = {
    'Islamabad': [
      {'name': 'Edhi Ambulance', 'number': '051-115'},
      {'name': 'Civil Hospital', 'number': '555-0311'},
      {'name': 'Police Emergency', 'number': '051-15'},
      {'name': 'Rescue Service', 'number': '051-1122'},
      {'name': 'Aurat Foundation', 'number': '051-26089568'},
      {'name': 'Madadgar', 'number': '111-9111-922'},
      {'name': 'ROZAN', 'number': '051-2890505-7'},
      {'name': 'Fire Brigade', 'number': '16'},
      // Add more Islamabad helpline data here...
    ],
    'Karachi': [
      {'name': 'Edhi Ambulance', 'number': '021-115'},
      {'name': 'Aga Khan Hospital', 'number': '021-3493 0051'},
      // Add more Karachi helpline data here...
    ],
    'Lahore': [
      // Add Lahore helpline data here...
      {'name': 'Edhi Ambulance', 'number': '042-115'},
      {'name': 'Jinnah Hospital', 'number': '042-35928231'},
      // Add more Lahore helpline data here...
    ],
    'Peshawar': [
      // Add Peshawar helpline data here...
      {'name': 'Edhi Ambulance', 'number': '091-115'},
      {'name': 'Khyber Teaching Hospital', 'number': '091-9217140-47'},
      // Add more Peshawar helpline data here...
    ],
    // Add more cities and their helplines here...
  };

  // This will be the list of helplines shown in the UI
  List<Map<String, String>> currentHelplines = [];

  @override
  void initState() {
    super.initState();
    currentHelplines = cityHelplines[selectedCity] ?? [];
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $phoneNumber')),
      );
    }
  }

  void _onCityChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedCity = newValue;
        currentHelplines = cityHelplines[selectedCity] ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Helplines'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/darkbgwithfade.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedCity,
              icon: Icon(Icons.arrow_drop_down, color: Color(0xffbd0b79)),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Color(0xffbd0b79), fontSize: 18, fontWeight: FontWeight.w300),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: _onCityChanged,
              items: cityHelplines.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentHelplines.length,
                itemBuilder: (context, index) {
                  final helpline = currentHelplines[index];
                  return ListTile(
                    title: Text(
                      helpline['name'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      helpline['number'] ?? '',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.phone, color: Color(0xffbd0b79)),
                      onPressed: () => _makePhoneCall(helpline['number'] ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


