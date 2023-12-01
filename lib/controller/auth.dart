// import 'package:chattogether/apis/api.dart';
// import 'package:chattogether/apis/google_services.dart';
// import 'package:chattogether/view/loginscreen/login_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';


import 'package:chattogether/services/google_services.dart';

import 'package:flutter/cupertino.dart';


class AuthProviders1 extends ChangeNotifier {


  Future googleSignInFunction(context) async {
    await GoogleSignServices().signInWithGoogle(context);
    notifyListeners();
  }


}
