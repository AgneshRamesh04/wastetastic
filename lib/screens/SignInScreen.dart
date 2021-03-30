import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/screens/ForgotPasswordScreen.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:wastetastic/control/LoginMgr.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

final _formKey = GlobalKey<FormState>();

class SignInScreen extends StatefulWidget {
  static String id = 'sigin_page';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

String enteredPassword = "";
String enteredUsername = "";

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            colors: [
              Colors.lightGreen.shade700,
              Colors.lime.shade400,
            ], //Colors.green[700], Colors.lime[200]],
            //center: Alignment(0.0, 0.0),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      //backgroundImage: AssetImage('')
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage('assets/images/wastetastic_1.png'),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 110.0,
                      child: TypewriterAnimatedTextKit(
                        text: [
                          "Login",
                        ],
                        textStyle: TextStyle(
                            fontSize: 35.0, fontFamily: "Source Sans Pro"),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 7.5),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "Enter Username" : null,
                        onChanged: (value) {
                          enteredUsername = value;
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
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter Password" : null,
                          onChanged: (value) {
                            enteredPassword = value;
                          },
                          obscureText: _obscureText,
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.teal[900]),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 20),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 14
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal[900]),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        )),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgotPasswordScreen.id);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SimpleButton(
                      content: 'Login',
                      onPress: () async {
                        //print(enteredPassword);
                        //print(enteredUsername);

                        if (_formKey.currentState.validate()) {
                          var k = await LoginMgr.loginToSystem(
                              enteredUsername, enteredPassword);
                          if (k)
                            Navigator.pushNamed(context, MainScreen.id);
                          else {
                            /*showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text('Wrong Username or Password'),
                                  ),
                                  content: Text(
                                    'You have entered a wrong username or password, '
                                    'please re-entered',
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      textColor: Colors.grey,
                                      child: const Text('Continue'),
                                    ),
                                  ],
                                );
                              },
                            );*/

                            /*_scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'You have entered a wrong username or password, '
                                  'please re-enter.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );*/
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message:
                                    "Wrong username or password. Please check your credentials and try again.",
                              ),
                            );
                          }
                        }
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
