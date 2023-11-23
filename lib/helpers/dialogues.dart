import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dialogs {
  static void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("msg")));
  }
}


