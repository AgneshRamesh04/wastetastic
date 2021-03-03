import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';

final _formKey = GlobalKey<FormState>();

String enteredName;
String enteredUsername;
String enteredEmail;
String enteredPassword;
String enteredConfirmPassword;

class signup extends StatefulWidget {
  static String id = 'signin_page';
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Colors.green[700], Colors.lime[200]],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/wastetastic_1.png',
                        fit: BoxFit.contain,
                        height: 70,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Enter Name";
                            enteredName = value;
                            return null;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 50,
                          decoration: InputDecoration(
                            icon: Icon(Icons.perm_identity_rounded,
                                color: Colors.teal[900]),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Enter Email";
                            if (!value.contains('@'))
                              return "Enter Valid Email";
                            enteredEmail = value;
                            return null;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 50,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email_rounded,
                                color: Colors.teal[900]),

                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
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
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Enter Password";
                            enteredPassword = value;
                            return null;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key_rounded,
                                color: Colors.teal[900]),

                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Confirm Password";
                            if (value != enteredPassword)
                              return "Passwords Dont Match";
                            enteredConfirmPassword = value;
                            return null;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.vpn_key_outlined,
                                color: Colors.teal[900]),

                            labelText: 'Confirm Password',

                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                      ),
                      SimpleButton(
                        content: 'Sign Up',
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
      ),
    );
  }
}
