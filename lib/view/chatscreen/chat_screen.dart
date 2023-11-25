import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/apis/api.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/view/homeScreen/home.dart';
import 'package:chattogether/view/homeScreen/chat_user_widget.dart/chat_user_card.dart';
import 'package:chattogether/view/chatscreen/widgets/chatscreenappbar/appbar.dart';
import 'package:chattogether/view/chatscreen/messages.dart/messagecard.dart';
import 'package:chattogether/view/chatscreen/widgets/chatscreenappbar/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // store massages
  List<MessageModel> _list = [];

  // for handling msg text changes
  // final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          flexibleSpace: custom_appbar(widget: widget),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 248, 255),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: Apis.getAllMessage(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return SizedBox();

                      case ConnectionState.active:
                      case ConnectionState.done:
                        // final data = snapshot.data?.docs;
                        // print('Data:${jsonEncode(data![0].data())}');
                        // if (snapshot.hasData) {
                        final data = snapshot.data?.docs;

                        _list = data
                                ?.map((e) => MessageModel.fromJson(e.data()))
                                .toList() ??
                            [];
                        // for (var i in data!) {
                        //   print('Data : ${jsonEncode(i.data())}');
                        //   list.add(i.data()['name']);
                        // }
                        // }

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              itemCount: _list.length,
                              padding: EdgeInsets.only(top: mq.height * .01),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MessageCard(message: _list[index]);
                              });
                        } else {
                          return const Center(
                            child: Text(
                              "Say Hi!👋",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                    }
                  }),
            ),
            Customtextfield(
              user: widget.user,
            ),
          ],
        ),
      ),
    );
  }
}
