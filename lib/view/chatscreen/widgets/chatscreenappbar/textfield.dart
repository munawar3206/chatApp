import 'dart:io';

import 'package:chattogether/controller/message_provider.dart';

import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Customtextfield extends StatelessWidget {
  ChatUser user;
  Customtextfield({super.key, required this.user});

//  for handling msg text changes
  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageProvider>(context);
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
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Color.fromARGB(255, 25, 0, 255),
                      )),
                  Expanded(
                      child: TextField(
                    controller:messageprovider.textController,
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

                          messageprovider.senderchatMessageProvider(
                              user, File(image.path));
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
                       
                          messageprovider.senderchatMessageProvider(
                              user, File(image.path));
                          
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
              if (messageprovider.textController.text.isNotEmpty) {
                messageprovider.sendMessageProvider(
                    user, Type.text);

                messageprovider.textController.text = '';
              }
            },
            minWidth: 0,
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(
              Icons.send,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 26,
            ),
          )
        ],
      ),
    );
  }
}
