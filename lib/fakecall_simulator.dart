import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:safeguardher/fakecall_incomingcall.dart';
import 'dart:async';

class FakeCall_Simulator extends StatefulWidget {
  const FakeCall_Simulator({Key? key}) : super(key: key);

  @override
  State<FakeCall_Simulator> createState() => _FakeCall_SimulatorState();
}

class _FakeCall_SimulatorState extends State<FakeCall_Simulator> {
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
    final selectedDateTime = DateTime(today.year, today.month, today.day,
        selectedTime!.hour, selectedTime!.minute);

    final formattedTime = "${selectedTime!.format(context)}";
    final name = myController.text;
    final language = selectedlang ?? 'Unknown';

    var duration = selectedDateTime.difference(now);
    if (duration.isNegative) {
      // If the selected time is in the past, schedule for the next day
      duration += Duration(days: 1);
    }

    // Show scheduled call dialog
    _showScheduledCallDialog(formattedTime, name, language);

    Future.delayed(duration, () {
      // Trigger navigation to the fakeCallNow page at the scheduled time
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => fakeCallNow(
            value: myController.text,
            selectedGender: selectedValue,
            selectedLang: selectedlang!,
          ),
        ),
      );
    });
  }


  void _showScheduledCallDialog(String time, String name, String language) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fake Call Scheduled"),
          content: Text("Fake Call is scheduled at $time from $name in $language."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fake Call Simulator', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xff48032f),
          // Customize your AppBar theme here
          elevation: 0,

          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white, // active tab text color
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(text: 'Call Now'),
              Tab(text: 'Schedule Call'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // ===============================================================================================================
            // ===============================================================================================================
            // ===                                          CALL NOW TAB                                                   ===
            // ===============================================================================================================
            // ===============================================================================================================
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundlogin.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: 200),
                    // Adjust the path and size as needed
                    SizedBox(height: 40),
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedValue,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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

                    //SELECTED LANGUAGE
                    DropdownButtonFormField<String>(
                      value: selectedlang,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                        backgroundColor: Color(0xFFF54184),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(08.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
            ),
            // ===============================================================================================================
            // ===============================================================================================================
            //                                            SCHEDULE LATER TAB
            // ===============================================================================================================
            // ===============================================================================================================
            // Second Tab: Schedule Call
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgroundlogin.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: 200),
                    // SizedBox(height: 20),
                    //Image.asset('assets/images/logo.png', width: 200), // Adjust the path and size as needed
                    // SizedBox(height: 20),
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: selectedValue,
                      decoration: InputDecoration(
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                        fillColor: Colors.white.withOpacity(0.8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                    SizedBox(height: 20),
                    // Button for time selection
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xFFBEBEBE),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: Text(selectedTime == null
                          ? 'Select Time'
                          : 'Time: ${selectedTime!.format(context)}'),
                    ),
                    SizedBox(height: 10),
                    // Button to schedule the call
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFF54184),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      child: const Text('Schedule Call'),
                      onPressed: () => _scheduleFakeCall(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
