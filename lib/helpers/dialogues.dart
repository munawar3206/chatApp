import 'package:flutter/material.dart';


class Dialogs {
  static void showSnackbar(BuildContext context,String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

late Size mq;