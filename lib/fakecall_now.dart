import 'package:flutter/material.dart';

class fakecall_now extends StatefulWidget {
  const fakecall_now({super.key});

  @override
  State<fakecall_now> createState() => _fakecall_nowState();
}

class _fakecall_nowState extends State<fakecall_now> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Caller',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),

              ),
              Text(
                  "555 5555 5555",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 2.2,),
              Row(children: [
                Column(children: [
                  GestureDetector(
                      child:FloatingActionButton(
                          child: Icon(Icons.call_end, size: 34),
                          background: Colors.red
                      ))
                ],

                )
              ],)

            ],
          )
        ],
      ),
    );
  }
}
