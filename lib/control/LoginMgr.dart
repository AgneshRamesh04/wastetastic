import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';

class LoginMgr {
  static final _firestore = FirebaseFirestore.instance;

  static Future<bool> verifyCredentials(
      String username, String enteredPassword) async {
    var userAccount =
        await _firestore.collection('UserAccounts').doc(username).get();
    //print(userAccount);
    if (userAccount.exists) {
      Map<String, dynamic> user = userAccount.data();
      if (enteredPassword == user['password']) {
        UserAccount userDetails = await UserAccountMgr.readUserDetails(username);
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }

  static dynamic loginToSystem(String username, String password) async {
    var login = await verifyCredentials(username, password);
    return login;
  }
}
