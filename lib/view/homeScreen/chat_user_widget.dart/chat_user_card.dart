import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/controller/homeprovider.dart';
import 'package:chattogether/helpers/date.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/services/services.dart';
import 'package:chattogether/view/chatscreen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatUserCard extends StatelessWidget {
  final ChatUser User;
   ChatUserCard({super.key, required this.User});

  // last msg info (if null ---no msg)
  MessageModel? _messageModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Color.fromARGB(201, 83, 83, 83),
      elevation: 0.5,
      shape: const RoundedRectangleBorder(),
      child: InkWell(onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      user: User,
                    )));
      }, child: Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider value, Widget? child) {
          return StreamBuilder(
              stream: value.getLastMessageProvider(User),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list = data
                        ?.map((e) => MessageModel.fromJson(e.data()))
                        .toList() ??
                    [];
                if (list.isNotEmpty) _messageModel = list[0];

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: mq.height * .055,
                      height: mq.height * .055,
                      imageUrl: User.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  title: Text(User.name),
                  subtitle: Text(
                      _messageModel != null
                          ? _messageModel!.type == Type.image
                              ? 'Image'
                              : _messageModel!.msg
                          : User.about,
                      maxLines: 1),
                  trailing: _messageModel == null
                      // show nothing when no msg is sent
                      ? null
                      : _messageModel!.read.isEmpty &&
                              _messageModel!.fromId != Services.user.uid
                          // show unread msg
                          ? Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:const Color.fromARGB(255, 3, 157, 8),
                              ),
                            )
                          : Text(MyDateUtil.getLastMessageTime(
                              context: context, time: _messageModel!.sent)),
                );
              });
        },
      )),
    );
  }
}
