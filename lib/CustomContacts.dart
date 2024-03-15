// import 'dart:convert';
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
  List<Contact> _filteredContacts = []; // For displaying filtered contacts based on search
  Set<String> _selectedContactIds = Set<String>();
  bool _isLoading = true; // Loading state indicator
  TextEditingController _searchController = TextEditingController(); // Search controller

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLoadContacts();
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose controller when the widget is disposed
    super.dispose();
  }

  Future<bool> _requestPermissions() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  void _checkPermissionsAndLoadContacts() async {
    final hasPermissions = await _requestPermissions();
    if (hasPermissions) {
      _loadContacts();
    } else {
      print('Contact permission not granted');
    }
  }

  void _loadContacts() async {
    setState(() => _isLoading = true);
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      _contacts = contacts.toList();
      _filteredContacts = _contacts;
      _isLoading = false;
    });
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    final filteredContacts = _contacts.where((contact) {
      final contactName = contact.displayName?.toLowerCase() ?? '';
      return contactName.contains(query);
    }).toList();

    setState(() {
      _filteredContacts = filteredContacts;
    });
  }

  void _toggleContactSelection(String contactId) {
    setState(() {
      if (_selectedContactIds.contains(contactId)) {
        _selectedContactIds.remove(contactId);
      } else {
        _selectedContactIds.add(contactId);
      }
    });
  }

  void _saveSelectedContacts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? existingSavedContacts = prefs.getStringList('selectedContacts') ?? [];
    Set<String> updatedContacts = Set.from(existingSavedContacts)..addAll(_selectedContactIds);
    await prefs.setStringList('selectedContacts', updatedContacts.toList());
    Navigator.pop(context); // Navigate back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select Contacts', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveSelectedContacts,
          ),
        ],
        backgroundColor: Color(0xff463344),
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
                hintText: 'Search by name',
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
                final isSelected = _selectedContactIds.contains(contact.identifier);
                return ListTile(
                  title: Text(contact.displayName ?? 'No Name'),
                  trailing: Icon(
                    isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                  onTap: () => _toggleContactSelection(contact.identifier!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
