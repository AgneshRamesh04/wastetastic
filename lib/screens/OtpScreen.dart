import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastetastic/control/OTPMgr.dart';
import 'package:wastetastic/control/RegistrationMgr.dart';
import 'package:wastetastic/screens/ForgotPasswordScreen.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/ResetPaswordScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:wastetastic/screens/SignUpScreen.dart';

TextEditingController emailController = new TextEditingController();

final _formKey = GlobalKey<FormState>();
String enteredOTP;

class OTPScreen extends StatefulWidget {
  static String id = 'OTP_Screen';
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    String name = args['name'];
    String username = args['username'];
    String email = args['email'];
    String password = args['password'];
    bool SignUp = args['SignUp'];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
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
                  SizedBox(height: 150),
                  Text('OTP Screen',
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  Container(
                    margin: EdgeInsets.all(25),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) return "Enter OTP";
                        return null;
                      },
                      onChanged: (value) {
                        enteredOTP = value;
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
                  SimpleButton(
                    content: 'Submit',
                    onPress: () {
                      if (_formKey.currentState.validate()) {
                        if (OTPMgr.verifyOTP(email, enteredOTP)) {
                          if (SignUp)
                            RegistrationMgr.registerUserAccount(
                                name, email, password, username);
                          SignUp
                              ? Navigator.pushNamed(
                                  context,
                                  MainScreen.id,
                                )
                              : Navigator.pushNamed(
                                  context,
                                  ResetPasswordScreen.id,
                                  arguments: {
                                    'email': args['email'],
                                    'forgot_password': true,
                                  },
                                );
                        } else {
                          print('Wrong otp entered, retry');
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: Center(
                                  child: Text('Wrong OTP'),
                                ),
                                content: Text(
                                  'You have entered a wrong OTP.\n' +
                                      OTPMgr.numAttempts.toString() +
                                      ' attempts left.',
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    textColor: Colors.grey,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              );
                            },
                          );

                          if (OTPMgr.maxTries()) {
                            SignUp
                                ? Navigator.popUntil(context,
                                    ModalRoute.withName(SignUpScreen.id))
                                : Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(
                                        ForgotPasswordScreen.id));
                          }
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
    );
  }
}
