import 'package:chattogether/main.dart';
import 'package:chattogether/model/model.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser User;
  const ChatUserCard({super.key, required this.User});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      // color: Color.fromARGB(201, 83, 83, 83),
      elevation: 0.5,
      shape: const RoundedRectangleBorder(),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.person),
          ),
          title: Text(widget.User.name),
          subtitle: Text(
            widget.User.about,
            maxLines: 1,
          ),
          trailing: const Text("12:23 PM"),
        ),
      ),
    );
  }
}
