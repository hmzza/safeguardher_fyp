import 'package:flutter/material.dart';
import 'package:safeguardher/fakecall_now.dart';

class fakecall extends StatefulWidget {
  const fakecall({Key? key}) : super(key: key);

  @override
  State<fakecall> createState() => _FakeCallState();
}

class _FakeCallState extends State<fakecall>
{
  final List<String> items = ['Male', 'Female'];
  String? selectedValue = 'Male';

  final List<String> language = ['Urdu', 'Punjabi', 'Pashto', 'Sindhi','Balochi'];
  String? selectedlang = 'Urdu';


  get selectedItem => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Call Simulator'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundlogin.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1, right: 65, left: 65 ),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade50,
                  filled: true,
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2, right: 65, left: 65 ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 240,
                  height: 50,
                  child: DropdownButton<String>(
                    value: selectedValue,
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 24)),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    // Adding decoration for DropdownButton
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    elevation: 16,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    dropdownColor: Colors.grey,
                  ),
                ),

              ],
            ),

          ),
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.3, right: 65, left: 65 ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 240,
                  height: 50,
                  child: DropdownButton<String>(
                    value: selectedlang,
                    items: language.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 24)),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedlang = value;
                      });
                    },
                    // Adding decoration for DropdownButton
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    elevation: 16,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    dropdownColor: Colors.grey,
                  ),
                ),

              ],
            ),

          ),

          Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.width * 0.5 - 100, // Centered horizontally
                      child: Container(
                        height: 52,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                      ),
                          child: const Text('Call Now'),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) =>
                                new fakecall_now())
                            );

                          },
                        ),
                      ),
          ),

        ],
      ),
    );
  }
}
