import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

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
        await _firestore.collection('UserAccounts').doc('$username').set({
          'name': name,
          'email': userEmail,
          'password': password,
          'points': 0
        });
        UserAccountMgr.readUserDetails(username);
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

  static Future<String> validateUsername_Email(
      String username, String email) async {
    await for (var snapshot
        in _firestore.collection('UserAccounts').snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        //print(docs.length);
        for (var Documents in documents) {
          if (Documents.id == username) return "Username";
          if (Documents['email'] == email) return "Email";
        }
      }
      return null;
    }
    return null;
  }
}
