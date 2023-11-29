import 'dart:io';

import 'package:chattogether/apis/api.dart';
import 'package:chattogether/helpers/date.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessageProvider(user) {
    return Services.getAllMessage(user);
  }

  Future sendMessageProvider(ChatUser chatUser, type) async {
    await Services.sendMessage(chatUser, textController.text, type);
    notifyListeners();
  }

  Future senderchatMessageProvider(ChatUser chatUser, File file) async {
    await Services.sentChatMessage(chatUser, file);
    notifyListeners();
  }

  Future UpdateMsgStatusProvider(MessageModel message) async {
    await Services.updateMessageReadStatus(message);
    notifyListeners();
  }

  Future getFormmatedDateProvider(BuildContext context, String time) async {
    await MyDateUtil.getFrommattedTime(context: context, time: time);
    notifyListeners();
  }
}
