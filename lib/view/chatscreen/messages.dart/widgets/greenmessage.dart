import 'package:cached_network_image/cached_network_image.dart';

import 'package:chattogether/helpers/date.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/view/chatscreen/messages.dart/messagecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GreenMessage extends StatelessWidget {
  const GreenMessage({
    super.key,
    required this.widget,
  });

  final MessageCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .01),
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                border: Border.all(color: Colors.lightGreen),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: widget.message.type == Type.text
                ? Text(widget.message.msg)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                      imageUrl: widget.message.msg,
                      placeholder: (context, url) => const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
          ),
        ),
        Text(
          MyDateUtil.getFrommattedTime(
              context: context, time: widget.message.sent),
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        const SizedBox(
          width: 5,
        ),
        if (widget.message.read.isNotEmpty)
          const Icon(
            Icons.done_all_rounded,
            color: Colors.blue,
          ),

      ],
    );
  }
}
