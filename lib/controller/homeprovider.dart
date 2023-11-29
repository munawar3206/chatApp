import 'package:chattogether/apis/api.dart';
import 'package:chattogether/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  // HomeProvider() {
  //   getSelfInfoProvider();
  // }
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersProvider() {
    return Services.getAllUsers();
  }

  Future getSelfInfoProvider() async {
    await Services.getSelfInfo();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessageProvider(lastmsg) {
    return Services.getLastMessage(lastmsg);
  }




}
