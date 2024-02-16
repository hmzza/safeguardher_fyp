import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall_now.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class fakecall extends StatefulWidget {
  const fakecall({Key? key}) : super(key: key);

  @override
  State<fakecall> createState() => _FakeCallState();
}

class _FakeCallState extends State<fakecall> {
  final List<String> items = ['Male', 'Female'];
  String? selectedValue = 'Male';

  final List<String> language = ['Urdu', 'Punjabi', 'Pashto', 'Sindhi', 'Balochi'];
  String? selectedlang = 'Urdu';

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Fake Call Simulator'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundlogin.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 100), // Adjust the path and size as needed
            SizedBox(height: 30),
            TextField(
              controller: myController,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.85),
                filled: true,
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.85),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedlang,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.85),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              items: language.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedlang = value;
                });
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Call Now'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => fakeCallNow(value: myController.text),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}