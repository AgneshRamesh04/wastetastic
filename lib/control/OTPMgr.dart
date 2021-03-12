import 'package:email_auth/email_auth.dart';

class OTPMgr {
  static int numAttempts;
  static void sendOTP(String email) async {
    numAttempts = 3;
    EmailAuth.sessionName = "Verification";
    var response = await EmailAuth.sendOtp(receiverMail: email);
    if (response) {
      print("OTP SENT");
    } else {
      print("problem encountered");
    }
  }

  static bool maxTries() {
    numAttempts--;
    if (numAttempts == 0) return true;
    return false;
  }

  static bool verifyOTP(String email, String otp) {
    var response = EmailAuth.validate(receiverMail: email, userOTP: otp);
    if (response) {
      return true;
    } else {
      return false;
    }
  }
}
