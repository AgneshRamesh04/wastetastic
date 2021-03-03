import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/screens/ForgotPassword.dart';
import 'package:wastetastic/screens/HomeScreen.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';

final _formKey = GlobalKey<FormState>();

class signin extends StatefulWidget {
  static String id = 'sigin_page';
  @override
  _signinState createState() => _signinState();
}

String enteredPassword;
String enteredUsername;

class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        /*leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),*/
        elevation: 0.0,
      ),
      //backgroundColor: Colors.lightGreen[200],
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.green[700], Colors.lime[200]],
            //center: Alignment(0.0, 0.0),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      //backgroundImage: AssetImage('')
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage('assets/images/wastetastic_1.png'),
                    ),
                    SizedBox(
                      width: 120.0,
                      child: TypewriterAnimatedTextKit(
                        text: [
                          "Login",
                        ],
                        textStyle: TextStyle(
                            fontSize: 40.0, fontFamily: "Source Sans Pro"),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Enter Username";
                        enteredUsername = value;
                        return null;
                      },
                      cursorColor: Colors.teal[900],
                      maxLength: 30,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Colors.teal[900]),
                        labelText: 'Username',
                        labelStyle:
                            TextStyle(color: Colors.teal[900], fontSize: 20),
                        // helperText: 'Number of characters',
                        // helperStyle: TextStyle(
                        //     color: Colors.teal[900],
                        //     fontSize: 14
                        // ),
                        //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal[900]),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) return "Enter Password";
                        enteredPassword = value;
                        return null;
                      },
                      obscureText: true,
                      cursorColor: Colors.teal[900],
                      maxLength: 30,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key_rounded,
                            color: Colors.teal[900]),

                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.teal[900], fontSize: 20),
                        // helperText: 'Number of characters',
                        // helperStyle: TextStyle(
                        //     color: Colors.teal[900],
                        //     fontSize: 14
                        // ),
                        //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal[900]),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgotPassword.id);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    SimpleButton(
                      content: 'LogIn',
                      onPress: () {
                        if (_formKey.currentState.validate())
                          Navigator.pushNamed(context, MainScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
