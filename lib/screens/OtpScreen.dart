import 'package:flutter/material.dart';

TextEditingController emailController = new TextEditingController();

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
              Text('OTP Screen',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Container(
                margin: EdgeInsets.all(25),
                child: TextFormField(
                  cursorColor: Colors.black,
                  maxLength: 6,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Colors.black),
                    labelText: 'OTP',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    helperText: 'Number of digits',
                    suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child: const Text('Reset Password',
                    style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
