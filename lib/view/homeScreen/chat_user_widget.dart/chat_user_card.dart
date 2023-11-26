import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/apis/api.dart';
import 'package:chattogether/helpers/date.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/view/chatscreen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser User;
  const ChatUserCard({super.key, required this.User});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  // last msg info (if null ---no msg)
  MessageModel? _messageModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Color.fromARGB(201, 83, 83, 83),
      elevation: 0.5,
      shape: const RoundedRectangleBorder(),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          user: widget.User,
                        )));
          },
          child: StreamBuilder(
              stream: Apis.getLastMessage(widget.User),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data
                        ?.map((e) => MessageModel.fromJson(e.data()))
                        .toList() ??
                    [];
                if (list.isNotEmpty) _messageModel = list[0];

                // if (data != null && data.first.exists) {
                //   _messageModel = MessageModel.fromJson(data.first.data());
                // }

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * .055,
                      imageUrl: widget.User.image,
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  title: Text(widget.User.name),
                  subtitle: Text(
                    _messageModel != null
                        ? _messageModel!.msg
                        : widget.User.about,
                    maxLines: 1,
                  ),
                  trailing: _messageModel == null
                      // show nothing when no msg is sent
                      ? null
                      : _messageModel!.read.isEmpty &&
                              _messageModel!.fromId != Apis.user.uid
                          // show unread msg
                          ? Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 3, 157, 8),
                              ),
                            )
                          : Text(MyDateUtil.getLastMessageTime(
                              context: context, time: _messageModel!.sent)),
                );
              })),
    );
  }
// 42
}
