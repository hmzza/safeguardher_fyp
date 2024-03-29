import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomContacts extends StatefulWidget {
  @override
  _CustomContactsState createState() => _CustomContactsState();
}

class _CustomContactsState extends State<CustomContacts> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  Set<String> _selectedContactIds = Set<String>();
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLoadContacts();
    _searchController.addListener(_filterContacts);
    _loadSelectedContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  void _checkPermissionsAndLoadContacts() async {
    if (await _requestPermissions()) {
      _loadContacts();
    } else {
      setState(() => _isLoading = false);
      print('Contact permission not granted');
    }
  }

  void _loadContacts() async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      _contacts = contacts.toList();
      _filteredContacts = _contacts;
      _isLoading = false;
    });
  }

  void _loadSelectedContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedContactIds =
        prefs.getStringList('selectedContacts');
    if (savedContactIds != null) {
      setState(() {
        _selectedContactIds = savedContactIds.toSet();
      });
    }
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        final contactName = contact.displayName?.toLowerCase() ?? '';
        return contactName.contains(query);
      }).toList();
    });
  }

  void _toggleContactSelection(String contactId) {
    final currentSelectedCount = _selectedContactIds.length;

    if (_selectedContactIds.contains(contactId)) {
      setState(() {
        _selectedContactIds.remove(contactId);
      });
    } else {
      if (currentSelectedCount < 5) {
        setState(() {
          _selectedContactIds.add(contactId);
        });
      } else {
        _showMaxSelectionError();
      }
    }
  }

  void _showMaxSelectionError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Limit Reached"),
          content: Text("You can only select a maximum of 5 contacts."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveSelectedContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedContacts', _selectedContactIds.toList());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Select Contacts')),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSelectedContacts,
          ),
        ],
        backgroundColor: Color(0xff48032f),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      final isSelected =
                          _selectedContactIds.contains(contact.identifier);
                      return ListTile(
                        title: Text(contact.displayName ?? 'No Name'),
                        trailing: Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: isSelected ? Color(0xFFF54184) : null,
                        ),
                        onTap: () =>
                            _toggleContactSelection(contact.identifier ?? ''),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
