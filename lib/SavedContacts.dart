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
    final List<String>? savedContactIds = prefs.getStringList('selectedContacts');

    if (savedContactIds != null && savedContactIds.isNotEmpty) {
      final Iterable<Contact> contacts = await ContactsService.getContacts();
      final List<Contact> filteredContacts = contacts.where((contact) => savedContactIds.contains(contact.identifier)).toList();

      setState(() {
        _savedContacts = filteredContacts;
      });
    }
  }

  void _navigateAndRefresh() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomContacts()));
    _loadSavedContacts();
  }

  void _deleteContact(String contactId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedContactIds = prefs.getStringList('selectedContacts');
    if (savedContactIds != null) {
      setState(() {
        _savedContacts.removeWhere((contact) => contact.identifier == contactId); // Remove from UI immediately
        savedContactIds.remove(contactId); // Remove from saved list
      });
      await prefs.setStringList('selectedContacts', savedContactIds);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Custom Contacts'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lightPinkBG.png"), // Specify your image path
            fit: BoxFit.cover,
          ),
        ),
        child: _savedContacts.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading indicator while loading contacts
            : _savedContacts.isEmpty
            ? Center(child: Text('No saved contacts.'))
            : ListView.builder(
          itemCount: _savedContacts.length,
          itemBuilder: (context, index) {
            final contact = _savedContacts[index];
            return ListTile(
              leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                  ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!))
                  : CircleAvatar(child: Text(contact.initials())),
              title: Text(contact.displayName ?? 'No Name'),
              subtitle: Text(
                contact.phones!.isNotEmpty ? contact.phones!.first.value! : 'No number available',
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteContact(contact.identifier!),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndRefresh,
        child: Icon(Icons.edit),
        tooltip: 'Edit Contacts',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 0), // Placeholder for your BottomAppBar
      ),
    );
  }
}
