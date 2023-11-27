import 'dart:io';

import 'package:chattogether/apis/api.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/view/homeScreen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _handleGoogleBtnClick() {
    _signInWithGoogle().then((user) async {
      if (user != null) {
        print('\nUser: ${user.user}');
        print('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        if ((await Apis.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Homepage()));
        } else {
          Apis.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Homepage()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
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
      print('\n _signInWithGoogle: $e');
      // return null;
      Dialogs.showSnackbar(context, 'Welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome to Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            width: mq.width * .5,
            left: mq.width * .25,
            child: Image.asset(
              "assets/communication.png",
            ),
          ),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width * .9,
            left: mq.width * .05,
            height: mq.height * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent.shade100,
                  shape: const StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                _handleGoogleBtnClick();
              },
              icon: Image.asset(
                "assets/google.png",
                height: mq.height * .03,
              ),
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                        text: "Sign In with ",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: "Google",
                        style: TextStyle(fontWeight: FontWeight.w900))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
