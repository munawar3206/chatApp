import 'package:chattogether/apis/api.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/view/chatscreen/messages.dart/widgets/bluemessage.dart';
import 'package:chattogether/view/chatscreen/messages.dart/widgets/greenmessage.dart';
import 'package:chattogether/view/chatscreen/messages.dart/widgets/option_item.dart';
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
        onLongPress: () {
          _showbottomsheet(isMe);
        },
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

// bottom sheet modify msg
  void _showbottomsheet(bool isMe) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.height * .015, horizontal: mq.width * .4),
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              widget.message.type == Type.text
                  ? OptionItem(
                      icon: const Icon(
                        Icons.copy_all_outlined,
                        color: Colors.blue,
                        size: 26,
                      ),
                      name: 'Copy Text',
                      onTap: () {})
                  : OptionItem(
                      icon: const Icon(
                        Icons.download_done_rounded,
                        color: Colors.blue,
                        size: 26,
                      ),
                      name: 'Save Image',
                      onTap: () {}),
              if (isMe)
                Divider(
                  color: Colors.black54,
                  endIndent: mq.width * .04,
                  indent: mq.width * .04,
                ),
              if (widget.message.type == Type.text && isMe)
                OptionItem(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: 'Edit Message',
                    onTap: () {}),
              if (isMe)
                OptionItem(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Color.fromARGB(255, 243, 33, 33),
                      size: 26,
                    ),
                    name: 'Delete Message',
                    onTap: () {}),
              Divider(
                color: Colors.black54,
                endIndent: mq.width * .04,
                indent: mq.width * .04,
              ),
              OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Color.fromARGB(255, 255, 251, 0),
                  ),
                  name: 'Sent At',
                  onTap: () {}),

              OptionItem(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                  ),
                  name: 'Read At',
                  onTap: () {}),

             
            ],
          );
        });
  }
}
