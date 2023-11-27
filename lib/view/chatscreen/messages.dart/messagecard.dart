import 'package:chattogether/apis/api.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/view/chatscreen/messages.dart/widgets/bluemessage.dart';
import 'package:chattogether/view/chatscreen/messages.dart/widgets/greenmessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});
  final MessageModel message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = Apis.user.uid == widget.message.fromId;
    return InkWell(
        onLongPress: () {},
        child: isMe
            ? BlueMessage(
                widget: widget,
              )
            : GreenMessage(widget: widget));

    // ? BlueMessage(widget: widget)
    // : GreenMessage(
    //     widget: widget,
    //   );
  }
}
