import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //removes the debug thingy from screen
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                margin: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage('images/wastastic.png'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Text('Forgot Password?',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Container(
                margin: EdgeInsets.all(25),
                child: TextFormField(
                  cursorColor: Colors.black,
                  maxLength: 100,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email, color: Colors.black),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    helperText: 'Number of characters',
                    suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child:
                    const Text('Request OTP', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
