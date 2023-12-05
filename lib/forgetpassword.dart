import 'package:flutter/material.dart';
import 'package:safeguardher/login.dart';


void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBarExample(),
      );
  }
}

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : true,
      body:  Container(
          child:  Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/forgetpassword.png")
              ]
          )

      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forget Password'),
        backgroundColor: Colors.grey,
        leading: IconButton(
          onPressed: () {

            Navigator.push(context, new MaterialPageRoute(
                builder: (context) =>
                new mylogin())
            );
          },
          icon: Icon(Icons.navigate_before_rounded,size: 35,),
        ),
      ),

    );
  }
}
