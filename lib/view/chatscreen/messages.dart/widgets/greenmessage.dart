import 'package:chattogether/main.dart';
import 'package:chattogether/view/chatscreen/messages.dart/messagecard.dart';
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
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
                vertical: mq.width * .04, horizontal: mq.height * .01),
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                border: Border.all(color: Colors.lightGreen),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Text(widget.message.msg),
          ),
        ),
        Text(
          widget.message.read + '12:00',
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.done_all_rounded,
          color: Colors.blue,
        ),

        // SizedBox(
        //   width: mq.width * .04,
        // )
      ],
    );
  }
}
