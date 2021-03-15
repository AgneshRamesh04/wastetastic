import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/control/OTPMgr.dart';
import 'package:wastetastic/control/RegistrationMgr.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:email_validator/email_validator.dart';

final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

String enteredName;
String enteredUsername;
String enteredEmail;
String enteredPassword;
String enteredConfirmPassword;

class signup extends StatefulWidget {
  static String id = 'signup_page';
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _obscureConfirmText = true;
  bool _obscureText = true;
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
                          validator: (value) =>
                              value.isEmpty ? "Enter Name" : null,
                          onChanged: (value) {
                            enteredName = value;
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
                          validator: (value) =>
                              value.isEmpty ? "Enter Password" : null,
                          onChanged: (value) {
                            enteredPassword = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          obscureText: _obscureText,
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
                            return null;
                          },
                          onChanged: (value) {
                            enteredConfirmPassword = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          obscureText: _obscureConfirmText,
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _obscureConfirmText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal[900]),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmText = !_obscureConfirmText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                      ),
                      SimpleButton(
                        content: 'Sign Up',
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            /* var  =
                                await RegistrationMgr.validateUsername_Email(
                                    enteredUsername, enteredEmail);
                            */
                            var username_emailExist =
                                await RegistrationMgr.validateUsername_Email(
                                    enteredUsername, enteredEmail);
                            print(username_emailExist);
                            if (username_emailExist == null) {
                              OTPMgr.sendOTP(enteredEmail);
                              Navigator.pushNamed(
                                context,
                                OTPScreen.id,
                                arguments: {
                                  'name': enteredName,
                                  'username': enteredUsername,
                                  'email': enteredEmail,
                                  'password': enteredPassword,
                                  'SignUp': true,
                                },
                              );
                            } else {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Entered ' +
                                        username_emailExist +
                                        ' already exist.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(seconds: 3),
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
      ),
    );
  }
}
