import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginMgr {
  static final _firestore = FirebaseFirestore.instance;

  static Future<bool> verifyCredentials(
      String username, String enteredPassword) async {
    var userAccount =
        await _firestore.collection('UserAccounts').doc(username).get();
    if (userAccount.exists) {
      Map<String, dynamic> user = userAccount.data();
      if (enteredPassword == user['password']) {
        return true;
      } else {
        return false;
      }
    }
  }
  static Future<bool> loginToSystem(String username, String password)
  {
    var login= verifyCredentials(username, password);
    return login;
  }
}
