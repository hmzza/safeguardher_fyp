import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CustomContacts.dart'; // Ensure this import points to your CustomContacts.dart file

class SavedContacts extends StatefulWidget {
  @override
  _SavedContactsState createState() => _SavedContactsState();
}

class _SavedContactsState extends State<SavedContacts> {
  List<Contact> _savedContacts = [];

  @override
  void initState() {
    super.initState();
    _loadSavedContacts();
  }

  void _loadSavedContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedContactIds =
    prefs.getStringList('selectedContacts');

    if (savedContactIds != null && savedContactIds.isNotEmpty) {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      final List<Contact> filteredContacts = contacts
          .where((contact) => savedContactIds.contains(contact.identifier))
          .toList();

      setState(() {
        _savedContacts = filteredContacts;
      });
    }
  }

  void _navigateAndRefresh() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CustomContacts()));
    _loadSavedContacts();
  }

  void _deleteContact(String contactId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedContactIds = prefs.getStringList('selectedContacts');
    if (savedContactIds != null) {
      setState(() {
        _savedContacts.removeWhere((contact) =>
        contact.identifier == contactId); // Remove from UI immediately
        savedContactIds.remove(contactId); // Remove from saved list
      });
      await prefs.setStringList('selectedContacts', savedContactIds);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Custom Contacts'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/darkbgwithfade.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _savedContacts.isEmpty
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                itemCount: _savedContacts.length,
                itemBuilder: (context, index) {
                  final contact = _savedContacts[index];
                  return ListTile(
                    leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                        ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!))
                        : CircleAvatar(child: Text(contact.initials())),
                    title: Text(
                      contact.displayName ?? 'No Name',
                      style: TextStyle(color: Colors.white), // Main text color
                    ),
                    subtitle: Text(
                      contact.phones!.isNotEmpty ? contact.phones!.first.value! : 'No number available',
                      style: TextStyle(color: Color(0xFFF54184)), // Subtext color
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Color(0xFFF54184)),
                      onPressed: () => _deleteContact(contact.identifier!),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Text(
                'These contacts will be\nnotified when an SOS is sent.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xA8F54184), // You can change this to the color that fits your design
                  fontSize: 16, // Adjust the size as needed
                  fontWeight: FontWeight.w300, // Adjust the weight as needed
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff48032f),
        onPressed: _navigateAndRefresh,
        child: Icon(Icons.add),
        tooltip: 'Edit Contacts',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 0), // Placeholder for your BottomAppBar
      ),
    );
  }

}
