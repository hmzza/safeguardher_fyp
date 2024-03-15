import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class ScheduleFakeCall extends StatefulWidget {
  const ScheduleFakeCall({Key? key}) : super(key: key);

  @override
  State<ScheduleFakeCall> createState() => _ScheduleFakeCallState();
}

class _ScheduleFakeCallState extends State<ScheduleFakeCall> {
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GeeksForGeeks'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Schedule Call'),
              Tab(text: 'Show Alarms & Timers'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First Tab: Schedule Call
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(11)),
                        child: Center(
                          child: TextField(
                            controller: hourController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(11)),
                        child: Center(
                          child: TextField(
                            controller: minuteController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: TextButton(
                      child: const Text(
                        'Schedule Call',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        int hour = int.parse(hourController.text);
                        int minutes = int.parse(minuteController.text);

                        // create alarm after converting hour
                        // and minute into integer
                        FlutterAlarmClock.createAlarm(hour: hour, minutes: minutes);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Second Tab: Show Alarms & Timers
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // show alarms
                      FlutterAlarmClock.showAlarms();
                    },
                    child: const Text(
                      'Show Alarms',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: TextButton(
                      child: const Text(
                        'Create Timer',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        int minutes;
                        minutes = int.parse(minuteController.text);

                        // create timer
                        FlutterAlarmClock.createTimer(length: minutes);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AboutDialog(
                              children: [
                                Center(
                                  child: Text(
                                    "Timer is set",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // show timers
                      FlutterAlarmClock.showTimers();
                    },
                    child: Text(
                      "Show Timers",
                      style: TextStyle(fontSize: 17),
                    ),
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

void main() {
  runApp(MaterialApp(
    home: ScheduleFakeCall(),
  ));
}
