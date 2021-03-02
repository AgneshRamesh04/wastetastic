import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class signin extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return MaterialApp (
      home: Scaffold(
        //backgroundColor: Colors.lightGreen[200],
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.green[700], Colors.lime[200]],
                //center: Alignment(0.0, 0.0),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    centerTitle: true,
                  ),
                  CircleAvatar(
                    radius: 60.0,
                    //backgroundImage: AssetImage('')
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage('images/wastetastic_1.png'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                  ),
                  SizedBox(
                    width: 120.0,
                    child: TypewriterAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      text: [
                        "Login",
                      ],
                      textStyle: TextStyle(
                          fontSize: 40.0,
                          fontFamily: "Source Sans Pro"
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: TextFormField(
                      cursorColor: Colors.teal[900],
                      maxLength: 30,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Colors.teal[900]),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: Colors.teal[900],
                            fontSize: 20
                        ),
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
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    child: TextFormField(
                      cursorColor: Colors.teal[900],
                      maxLength: 30,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key_rounded, color: Colors.teal[900]),

                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.teal[900],
                          fontSize: 20
                        ),
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


                  FlatButton(

                    onPressed: (){},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                  ),
                  SizedBox(
                    width: 270,
                    height: 60,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),

                      onPressed: (){},
                      color: Colors.lime[50],
                      padding: EdgeInsets.all(15.0),
                      child:
                      Text('Login',
                        style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 25.0,
                          color: Colors.teal[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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