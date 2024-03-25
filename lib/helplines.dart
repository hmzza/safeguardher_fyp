import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLines extends StatefulWidget {
  const HelpLines({Key? key}) : super(key: key);

  @override
  _HelpLinesState createState() => _HelpLinesState();
}

class _HelpLinesState extends State<HelpLines> {
  String selectedCity = 'Islamabad';
  List<Map<String, String>> allHelplines = [];
  List<Map<String, String>> filteredHelplines = [];
  final TextEditingController _searchController = TextEditingController();

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
  @override
  void initState() {
    super.initState();
    _updateFilteredHelplines(selectedCity);
  }

  void _updateFilteredHelplines(String city) {
    allHelplines = cityHelplines[city] ?? [];
    _filterHelplines();
  }

  void _filterHelplines() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredHelplines = allHelplines;
    } else {
      filteredHelplines = allHelplines
          .where((helpline) =>
      helpline['name']!.toLowerCase().contains(query) ||
          helpline['number']!.contains(query))
          .toList();
    }
    setState(() {});
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch $phoneNumber')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xff48032f),
        title: Text('Helplines', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  helplines: allHelplines,
                  searchFunction: _makePhoneCall,
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/darkbgwithfade.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay for better visibility
              child: DropdownButton<String>(
                value: selectedCity,
                dropdownColor: Color(0xFF363636),
                icon: Icon(Icons.arrow_downward, color: Color(0xFFF54184)),
                elevation: 16,
                style: TextStyle(color: Colors.white),
                underline: Container(height: 2, color: Color(0xFFF54184)),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCity = newValue;
                      _updateFilteredHelplines(newValue);
                    });
                  }
                },
                items: cityHelplines.keys.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.white)),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredHelplines.length,
                itemBuilder: (context, index) {
                  final helpline = filteredHelplines[index];
                  return Card(
                    color: Colors.black54,
                    child: ListTile(
                      title: Text(helpline['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      subtitle: Text(helpline['number'] ?? '', style: TextStyle(color: Color(0xFFF54184))),
                      trailing: IconButton(
                        icon: Icon(Icons.phone, color: Color(0xFFF54184)),
                        onPressed: () => _makePhoneCall(helpline['number']!),
                      ),
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

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> helplines;
  final Function(String) searchFunction;

  CustomSearchDelegate({required this.helplines, required this.searchFunction});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.black,
      appBarTheme: AppBarTheme(backgroundColor: Colors.black),
      inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.white)),
      textTheme: theme.textTheme.copyWith(headline6: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = helplines.where((helpline) => helpline['name']!.toLowerCase().contains(query.toLowerCase()) || helpline['number']!.contains(query)).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var result = results[index];
        return ListTile(
          title: Text(result['name'] ?? '', style: TextStyle(color: Colors.white)),
          subtitle: Text(result['number'] ?? '', style: TextStyle(color: Color(0xFFF54184))),
          trailing: Icon(Icons.phone, color: Color(0xFFF54184)),
          onTap: () => searchFunction(result['number']!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = helplines.where((helpline) => helpline['name']!.toLowerCase().contains(query.toLowerCase()) || helpline['number']!.contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion['name'] ?? '', style: TextStyle(color: Colors.black)),
          subtitle: Text(suggestion['number'] ?? '', style: TextStyle(color: Color(0xFFF54184))),
          trailing: Icon(Icons.phone, color: Color(0xFFF54184)),
          onTap: () => searchFunction(suggestion['number']!),
        );
      },
    );
  }
}