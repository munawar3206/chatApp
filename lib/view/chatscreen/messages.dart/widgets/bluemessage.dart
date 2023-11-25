import 'package:chattogether/helpers/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/view/chatscreen/messages.dart/messagecard.dart';
import 'package:flutter/material.dart';

class BlueMessage extends StatelessWidget {
  const BlueMessage({
    super.key,
    required this.widget,
  });

  final MessageCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.message.read.isNotEmpty)
          Icon(
            Icons.done_all_rounded,
            color: Colors.blue,
          ),
        SizedBox(
          width: 5,
        ),
        Text(
          MyDateUtil.getFrommattedTime(
              context: context, time: widget.message.sent),
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                vertical: mq.width * .04, horizontal: mq.height * .01),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlue),
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: Text(widget.message.msg),
          ),
        ),
        // SizedBox(
        //   width: mq.width * .04,
        // )
      ],
    );
  }
}
