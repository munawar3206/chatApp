import 'dart:io';

import 'package:chattogether/services/services.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String? image;

  void imageValueChange(value) {
    image = value;
    notifyListeners();
  }

  Future updateUserInfoProvider() async {
    await Services.updateUserInfo();
    notifyListeners();
  }

  Future updateProfilePicProvider(File file) async {
    await Services.updateProfilePicture(file);
    notifyListeners();
  }
}
