 import 'package:chattogether/services/google_services.dart';
import 'package:chattogether/services/services.dart';
import 'package:chattogether/view/homeScreen/home.dart';
import 'package:flutter/material.dart';

handleGoogleBtnClick(context) {
    GoogleSignServices().signInWithGoogle(context).then((user) async {
      if (user != null) {
        print('\nUser: ${user.user}');
        print('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        if (await Services.userExists()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Homepage()),
          );
        } else {
          Services.createUser().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Homepage()),
            );
          });
        }
      }
    });
  }