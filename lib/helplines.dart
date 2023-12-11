import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLines extends StatefulWidget {
  const HelpLines({super.key});

  @override
  State<HelpLines> createState() => _HelpLinesState();
}

class _HelpLinesState extends State<HelpLines> {
  String selectedCity = 'Islamabad'; // Default value for the dropdown

  // Dummy data for the list of helplines
  final List<Map<String, String>> helplines = [
    {'name': 'Edhi Ambulance', 'number': '051-115'},
    {'name': 'Civil Hospital', 'number': '555-0311'},
    {'name': 'Police Emergency', 'number': '051-15'},
    {'name': 'Rescue Service', 'number': '051-1122'},
    {'name': 'Aurat Foundation', 'number': '051-26089568'},
    {'name': 'Madadgar', 'number': '111-9111-922'},
    {'name': 'ROZAN', 'number': '051-2890505-7'},
    {'name': 'Fire Brigade', 'number': '16'},
    // Add more helpline data here...
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Helplines'),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lightPinkBG.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              DropdownButton<String>(
                value: selectedCity,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 26,
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).primaryColorDark,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
                items: <String>['Islamabad', 'Karachi', 'Lahore', 'Peshawar']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: helplines.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(helplines[index]['name']!, style: TextStyle(
                        fontSize: 20
                      ),),
                      subtitle: Text(helplines[index]['number']!, style: TextStyle(
                          fontSize: 15
                      )),
                      trailing: IconButton(
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          _makePhoneCall(helplines[index]['number']!);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      // You would also add your bottom navigation bar here
    );
  }
}
