import 'package:chattogether/apis/api.dart';
import 'package:chattogether/model/model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  ChatUser user;
  Customtextfield({super.key, required this.user});
//  for handling msg text changes
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // emoji

                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Color.fromARGB(255, 25, 0, 255),
                      )),
                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: "Text Something.....",
                        hintStyle: TextStyle(color: Colors.blueAccent),
                        border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera,
                        color: Color.fromARGB(255, 25, 0, 255),
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 25, 0, 255),
                      )),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                print("${_textController.text}");
                Apis.sendMessage(user, _textController.text);
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: CircleBorder(),
            color: Colors.green,
            child: Icon(
              Icons.send,
              color: const Color.fromARGB(255, 255, 255, 255),
              size: 26,
            ),
          )
        ],
      ),
    );
  }
}
