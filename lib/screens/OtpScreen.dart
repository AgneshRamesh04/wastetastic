import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/ResetPasword.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';

TextEditingController emailController = new TextEditingController();

final _formKey = GlobalKey<FormState>();
String enteredOTP;

class OTPScreen extends StatefulWidget {
  static String id = 'OPT_Screen';
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
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
                      onFieldSubmitted: (value) {
                        enteredOTP = value;
                        return null;
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Enter OTP";
                        enteredOTP = value;
                        return null;
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
                      if (_formKey.currentState.validate())
                        Navigator.pushNamed(context, ResetPassword.id);
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
