import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextEditingController emailController = new TextEditingController();

class ResetPassword extends StatefulWidget {
  static String id = 'Forgot_password_page';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                Text('Reset Password',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    maxLength: 100,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.black),
                      labelText: 'New Password',
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    maxLength: 100,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Colors.black),
                      labelText: 'Confirm Password',
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
                  child: const Text('Confirm', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
