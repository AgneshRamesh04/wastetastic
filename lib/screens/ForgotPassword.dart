import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:email_validator/email_validator.dart';
final _formKey = GlobalKey<FormState>();
String enteredEmail;

class ForgotPassword extends StatefulWidget {
  static String id = 'Forgot_Password_screen';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                    SizedBox(height: 100),
                    Text('Forgot Password?',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return "Enter Email";
                          final bool isValid = EmailValidator.validate(value);
                          if (isValid == false) return "Enter Valid Email";
                          return null;
                        },
                        onChanged: (value) {
                          enteredEmail = value;
                        },
                        cursorColor: Colors.black,
                        maxLength: 100,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.black),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          //helperText: 'Number of characters',
                          //suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SimpleButton(
                      content: 'Request OTP',
                      onPress: () {
                        if (_formKey.currentState.validate())
                          Navigator.pushNamed(context, OTPScreen.id);
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
