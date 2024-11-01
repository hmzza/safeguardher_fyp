import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safeguardher/aboutus.dart';
import 'package:safeguardher/changepassword.dart';
import 'package:safeguardher/editprofile.dart';
import 'package:safeguardher/helpandsupport.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:safeguardher/utils/imageprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'guide.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  Uint8List? _image;
  final _nameController = TextEditingController(); // Controller for the name field
  String? _name; // Variable to hold the name

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }
  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    // Use a default name if none is stored
    setState(() {
      _name = prefs.getString('name') ?? 'Your Name';
    });
    _nameController.text = _name!;
  }
  Future<void> _saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Settings', automaticallyImplyLeading: false),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/settingsBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: _image != null
                    ? MemoryImage(_image!)
                    : AssetImage('assets/images/profile_placeholder.jpg') as ImageProvider,
              ),
            ),
            TextButton(
              onPressed: selectImage,
              child: Text(
                'Change Profile Picture',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              'Saba Karim',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(height: 20, thickness: 2, color: Colors.white54),
            _settingOption(
              context,
              title: 'Edit Profile',
              icon: Icons.edit,
              destination: EditProfile(),
            ),
            _settingOption(
              context,
              title: 'Change Password',
              icon: Icons.lock_outline,
              destination: ChangePwd(),
            ),
            _settingOption(
              context,
              title: 'Guide (User Manual)',
              icon: Icons.menu_book,
              destination: Guide(), // Placeholder for user manual page
            ),
            _settingOption(
              context,
              title: 'Help & Support',
              icon: Icons.help_outline,
              destination: HelpAndSupport(),
            ),
            _settingOption(
              context,
              title: 'About Us',
              icon: Icons.info_outline,
              destination: AboutUs(),
            ),
            _logoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _settingOption(BuildContext context, {required String title, required IconData icon, required Widget destination}) {
    return Material(
      color: Colors.transparent, // This is important for the ripple effect
      child: InkWell(
        splashColor: Colors.white24, // Light white splash color for the ripple effect
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => destination)),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return Material(
      color: Colors.transparent, // This is important for the ripple effect
      child: InkWell(
        splashColor: Colors.redAccent.shade200, // Light red splash color for the ripple effect
        onTap: () {
          // TODO: Implement logout functionality
        },
        child: ListTile(
          leading: Icon(Icons.exit_to_app, color: Colors.red),
          title: Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

}


