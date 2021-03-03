import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/signin.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';

TextEditingController emailController = new TextEditingController();

final _formKey = GlobalKey<FormState>();
String newPassword;
String confirmPassword;

class ResetPassword extends StatefulWidget {
  static String id = 'Forgot_password_page';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text('Reset Password',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return "Enter Password";
                          newPassword = value;
                          return null;
                        },
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
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return "Enter Password";
                          if (value != newPassword)
                            return "Passwords Dont Match";
                          confirmPassword = value;
                          return null;
                        },
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
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SimpleButton(
                      content: 'Reset Password',
                      onPress: () {
                        if (_formKey.currentState.validate()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: Center(child: Text('Password Changed')),
                                content: Text(
                                    'You have successfully changed your account Password!!'),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, MainScreen.id);
                                    },
                                    textColor: Colors.grey,
                                    child: const Text('Continue To Home'),
                                  ),
                                ],
                              );
                            },
                          );
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
