import 'package:flutter/material.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/ResetPasword.dart';

TextEditingController emailController = new TextEditingController();

class OTPScreen extends StatefulWidget {
  static String id = 'OPT_Screen';
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String enteredOTP;
  @override
  Widget build(BuildContext context) {
    enteredOTP = null;
    return MaterialApp(
      debugShowCheckedModeBanner: false, //removes the debug thingy from screen
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage('assets/images/wastetastic_1.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20),
                Text('OTP Screen',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Container(
                  margin: EdgeInsets.all(25),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      enteredOTP = value;
                      return null;
                    },
                    cursorColor: Colors.black,
                    maxLength: 6,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.black),
                      labelText: 'OTP',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      helperText: 'Number of digits',
                      //suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (enteredOTP.isNotEmpty) {
                      Navigator.pushNamed(context, ResetPassword.id);
                    }
                  },
                  child: const Text('Reset Password',
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
