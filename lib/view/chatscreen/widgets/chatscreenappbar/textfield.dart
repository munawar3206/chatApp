import 'dart:io';

import 'package:chattogether/apis/api.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Customtextfield extends StatefulWidget {
  ChatUser user;
  Customtextfield({super.key, required this.user});

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
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
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
// Pick an image.
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 80);
                      if (image != null) {
                        // print(
                        //     "image path : ${image.path} --MimeType:${image.mimeType}");

                        Apis.sentChatMessage(widget.user, File(image.path));
                      }
                    },
                    icon: const Icon(
                      Icons.camera,
                      color: Color.fromARGB(255, 25, 0, 255),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
// Pick an image.
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          // print(
                          //     "image path : ${image.path} --MimeType:${image.mimeType}");

                          Apis.sentChatMessage(widget.user, File(image.path));
                        }
                      },
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
                Apis.sendMessage(widget.user, _textController.text,
                    Type.text); //////////////////////
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
