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

  static Future<void> registerUserAccount(
      String name, String email, String password, String username) async {
    final auth = FirebaseAuth.instance;

    try {
      print("Reached here");
      final newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Created User with Email and Password");
      if (newUser != null) {
        String userEmail = newUser.user.email;
        print("User email: " + userEmail);

//        while (r.num_attempts != 3) {
//          OTPMgr.sendOTP(userEmail);
//          bool result = OTPMgr.verifyOTP(userEmail, r.otp);
//          if (result) {
//            print("verified");
        print('About to write to firestore');
        await _firestore.collection('UserAccounts').doc('$username').set({
          'name': name,
          'email': userEmail,
          'password': password,
          'points': 0
        });
        await UserAccountMgr.readUserDetails(username);
        print('Hi');
        UserAccountMgr.userDetails.printUserDetails();
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
      print("Error!!");
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
