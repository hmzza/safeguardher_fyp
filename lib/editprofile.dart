import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Controllers to manage the text field content
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _cnicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Edit Profile'),
      body: Stack(
        children: <Widget>[
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/settingsBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Profile form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                _buildTextField(
                  controller: _nameController,
                  labelText: 'Name',
                  hintText: 'Saba Karim',
                ),
                _buildTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'sabakarim@email.com',
                ),
                _buildTextField(
                  controller: _mobileController,
                  labelText: 'Mobile number',
                  hintText: '+92-1234567890',
                ),
                _buildTextField(
                  controller: _cnicController,
                  labelText: 'CNIC',
                  hintText: '36302-1234567-8',
                ),
                SizedBox(height: 40), // Spacing before the save button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.pink, backgroundColor: Colors.white, // Text color
                  ),
                  onPressed: () {
                    // Implement save functionality
                  },
                  child: Text('SAVE',style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white), // Text in white
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white), // Label text in white
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54), // Hint text in white with some transparency
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Normal border color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Enabled border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Border color when the field is focused
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.edit, color: Colors.white), // Edit icon in white
            onPressed: () {
              // Implement your editing logic
            },
          ),
        ),
        cursorColor: Colors.white, // Cursor color
      ),
    );
  }

}
