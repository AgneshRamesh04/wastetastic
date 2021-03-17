import 'package:flutter/material.dart';
import 'package:wastetastic/screens/BasicTestingScreen.dart';
import 'package:wastetastic/screens/CarParkScreen.dart';
import 'package:wastetastic/screens/ForgotPassword.dart';
import 'package:wastetastic/screens/LoadingScreen.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/screens/MapTestingScreen.dart';
import 'package:wastetastic/screens/POIDetailsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wastetastic/screens/ResetPasword.dart';
import 'package:wastetastic/screens/signin.dart';
import 'package:wastetastic/screens/signup.dart';
import 'package:wastetastic/screens/welcomePage.dart';
import 'package:wastetastic/screens/MapScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastetastic',
      theme: ThemeData.dark(),
      initialRoute: welcomePage.id,
      routes: {
        BasicTestingScreen.id: (context) => BasicTestingScreen(),
        MainScreen.id: (context) => MainScreen(),
        MapScreen.id: (context) => MapScreen(),
        POI_DetialScreen.id: (context) => POI_DetialScreen(),
        NearYouScreen.id: (context) => NearYouScreen(),
        CarParkScreen.id: (context) => CarParkScreen(),
        ForgotPassword.id: (context) => ForgotPassword(),
        ResetPassword.id: (context) => ResetPassword(),
        OTPScreen.id: (context) => OTPScreen(),
        welcomePage.id: (context) => welcomePage(),
        signin.id: (context) => signin(),
        signup.id: (context) => signup(),
        LoadingScreen.id: (context) => LoadingScreen(),
        MapTestingScreen.id: (context) => MapTestingScreen(),
      },
    );
  }
}
