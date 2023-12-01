



import 'dart:io';

import 'package:chattogether/helpers/dialogues.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignServices {
  Future<UserCredential?> signInWithGoogle(context) async {
    // Trigger the authentication flow
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('\n signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'Welcome');
    }
    return null;
  }
}
