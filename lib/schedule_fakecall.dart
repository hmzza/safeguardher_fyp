import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:safeguardher/fakecall_now.dart';
import 'dart:async';

class ScheduleFakeCall extends StatefulWidget {
  const ScheduleFakeCall({Key? key}) : super(key: key);

  @override
  State<ScheduleFakeCall> createState() => _ScheduleFakeCallState();
}

class _ScheduleFakeCallState extends State<ScheduleFakeCall> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  final List<String> items = ['Male', 'Female'];
  String? selectedValue = 'Male';

  final List<String> language = ['English', 'Urdu'];
  String? selectedlang = 'Urdu';

  final myController = TextEditingController();

  TimeOfDay? selectedTime; // Variable to store the selected time

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Function to schedule the fake call
  void _scheduleFakeCall(BuildContext context) {
    if (selectedTime == null) return; // Ensure a time has been picked

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDateTime = DateTime(today.year, today.month, today.day, selectedTime!.hour, selectedTime!.minute);

    var duration = selectedDateTime.difference(now);
    if (duration.isNegative) {
      // If the selected time is in the past, schedule for the next day
      duration += Duration(days: 1);
    }

    Future.delayed(duration, () {
      // Trigger navigation to the fakeCallNow page at the scheduled time
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => fakeCallNow(
            value: myController.text,
            selectedGender: selectedValue!,
            selectedLang: selectedlang!,
          ),
        ),
      );
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:
        AppBar(
          title: const Text('Fake Call Simulator'),
          backgroundColor: Color(0xff48032f), // Customize your AppBar theme here
          elevation: 0,

          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Call Now'),
              Tab(text: 'Schedule Call'),

            ],
          ),
        ),

        body: TabBarView(

          children: [
            Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundlogin.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 200), // Adjust the path and size as needed
                SizedBox(height: 40),
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
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent,
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
                        builder: (context) => fakeCallNow(
                          value: myController.text,
                          selectedGender: selectedValue!,
                          selectedLang: selectedlang!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),


            // Second Tab: Schedule Call
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroundlogin.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Image.asset('assets/images/logo.png', width: 200), // Adjust the path and size as needed
                  SizedBox(height: 20),
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
                  // Button for time selection
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: Text(selectedTime == null ? 'Select Time' : 'Time: ${selectedTime!.format(context)}'),
                  ),
                  SizedBox(height: 40),
                  // Button to schedule the call
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text('Schedule Call'),
                    onPressed: () => _scheduleFakeCall(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
