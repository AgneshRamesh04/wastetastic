import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/control/OTPMgr.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:email_validator/email_validator.dart';

final _formKey = GlobalKey<FormState>();
String enteredEmail;

class ForgotPasswordScreen extends StatefulWidget {
  static String id = 'Forgot_Password_screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                    Text('Forgot Password?',
                        style: TextStyle(
                            fontSize: 35.0, color: Colors.white, fontFamily: "Source Sans Pro")),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) return "Enter Email";
                          final bool isValid = EmailValidator.validate(value);
                          if (isValid == false) return "Enter Valid Email";
                          return null;
                        },
                        onChanged: (value) {
                          enteredEmail = value;
                        },
                        cursorColor: Colors.teal[900],
                        maxLength: 50,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.teal[900]),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.teal[900], fontSize: 20,
                          ),
                          //helperText: 'Number of characters',
                          //suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SimpleButton(
                      content: 'Request OTP',
                      onPress: () {
                        Map args = {
                          'email': enteredEmail,
                          'SignUp': false,
                        };
                        if (_formKey.currentState.validate()) {
                          OTPMgr.sendOTP(enteredEmail);
                          Navigator.pushNamed(
                            context,
                            OTPScreen.id,
                            arguments: args,
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
    )
    );
  }
}
