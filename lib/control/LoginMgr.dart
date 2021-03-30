import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';

class LoginMgr {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;
  static Future<bool> verifyCredentials(
      String username, String enteredPassword) async {
    var userAccount =
        await _firestore.collection('UserAccounts').doc(username).get();
    //print(userAccount);
    if (userAccount.exists) {
      String email = userAccount.data()['email'];
//      if (enteredPassword == user['password']) {
//        await UserAccountMgr.readUserDetails(username);
//        return true;
//      } else {
//        return false;
//      }
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: enteredPassword);
        if (user != null) return true;
      } catch (e) {
        print(e);
        return false;
      }
    }
    return false;
  }

  static dynamic loginToSystem(String username, String password) async {
    var login = await verifyCredentials(username, password);
    return login;
  }
}
