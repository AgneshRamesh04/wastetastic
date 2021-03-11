import 'package:flutter/material.dart';
import 'package:wastetastic/entity/UserAccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'OTPMgr.dart';

class RegistrationMgr {
//  int num_attempts;
//  String otp;
//
//  RegistrationMgr(int num_attempts) {
//    num_attempts = num_attempts;
//  }

  static final _firestore = FirebaseFirestore.instance;
  //RegistrationMgr r = RegistrationMgr(1);

//  void incrementNumAttempts() {
//    r.num_attempts++;
//  }

  static void registerUserAccount(
      String name, String email, String password, String username) async {
    final auth = FirebaseAuth.instance;

    try {
      final newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        String userEmail = newUser.user.email;

//        while (r.num_attempts != 3) {
//          OTPMgr.sendOTP(userEmail);
//          bool result = OTPMgr.verifyOTP(userEmail, r.otp);
//          if (result) {
//            print("verified");
        _firestore
            .collection('UserAccounts')
            .doc('$username')
            .set({'name': name, 'email': userEmail, 'password': password});
        //add navigation here to the home screen
//            break;
//          } else {
//            incrementNumAttempts();
//          }
//          if (num_attempts == 3) {
//            print("failed");
//            //Navigate back to the signup page.
//          }
//        }
      }
    } catch (e) {
      // need to display this error onto screen instead of
      print(e);
    }
  }
}
