import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/controller/message_provider.dart';
import 'package:chattogether/helpers/date.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:chattogether/view/chatscreen/messages.dart/messagecard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlueMessage extends StatelessWidget {
  const BlueMessage({
    super.key,
    required this.widget,
  });

  final MessageCard widget;

  @override
  Widget build(BuildContext context) {
   
    return Consumer<MessageProvider>(

      builder: (BuildContext context, messageprovider, Widget? child,) { 
 if (widget.message.read.isEmpty) {
      messageprovider.UpdateMsgStatusProvider(widget.message);
      // print("Message Updated");
    }
    return  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.message.read.isEmpty)
            const Icon(
              Icons.done_all_rounded,
              color: Colors.blue,
            ),
          const SizedBox(
            width: 5,
          ),
          Text(
            MyDateUtil.getFrommattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(widget.message.type == Type.image
                  ? mq.width * .03
                  : mq.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical: mq.height * .01),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue),
                  color: Colors.blue.shade100,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: widget.message.type == Type.text
                  ? Text(widget.message.msg)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 200,
                        width: 200,
                        imageUrl: widget.message.msg,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                        errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(
                            CupertinoIcons.person,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      );
       },
      
    );
  }
}
