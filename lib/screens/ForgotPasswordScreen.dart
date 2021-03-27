import 'package:flutter/material.dart';
import 'package:wastetastic/control/OTPMgr.dart';
import 'package:wastetastic/control/RegistrationMgr.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:email_validator/email_validator.dart';

final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        key: _scaffoldKey,
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
                colors: [
                  Colors.lightGreen.shade700,
                  Colors.lime.shade400,
                ],
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
                                fontSize: 35.0,
                                color: Colors.white,
                                fontFamily: "Source Sans Pro")),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) return "Enter Email";
                              final bool isValid =
                                  EmailValidator.validate(value);
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
                                color: Colors.teal[900],
                                fontSize: 20,
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
                          onPress: () async {
                            Map args = {
                              'email': enteredEmail,
                              'SignUp': false,
                            };
                            if (_formKey.currentState.validate()) {
                              var emailExist =
                                  await RegistrationMgr.validateUsername_Email(
                                      null, enteredEmail);
                              if (emailExist != "Email") {
                                print('incorrect email');
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Entered email - ' +
                                          enteredEmail +
                                          ' is not registered.',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                OTPMgr.sendOTP(enteredEmail);
                                Navigator.pushNamed(
                                  context,
                                  OTPScreen.id,
                                  arguments: args,
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
        ));
  }
}
