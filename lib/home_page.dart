import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Image.asset('assets/backarrow.png'),
        //   onPressed: () {
        //     // Handle back button action
        //   },
        // ),
        title: Text('Hi, Saba'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundlogin.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget> [
              Column(
                children: [
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/threatdetection.png"
                              ),
                              fit: BoxFit.cover
                          )
                      ),
                      child:
                          Padding(
                          padding: EdgeInsets.all(50),
                          child:     Text('Yo Hamza my BITCH!!! 2', style: TextStyle(color: Colors.white),),
                          )
                    ),
                  ),
                  Text('Yo Hamza my BITCH!!!', style: TextStyle(color: Colors.white),),
                ],
              ),
            Row(
              children: [
                Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/fakecall.png"
                        ),
                        fit: BoxFit.cover
                    )
                   ),
                  ),
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/sos.png"
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                ),

              ],
             )
            ],
          ),
        ],
      ),
    );
  }
}
