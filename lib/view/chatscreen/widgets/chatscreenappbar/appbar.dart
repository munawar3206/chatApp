
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/view/chatscreen/chat_screen.dart';
import 'package:chattogether/view/homeScreen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class custom_appbar extends StatelessWidget {
  const custom_appbar({
    super.key,
    required this.widget,
    // required this.widget,
  });

  final ChatScreen widget;
 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      },
      icon: Icon(
        Icons.arrow_back,
        color: const Color.fromARGB(255, 255, 255, 255),
      )),
        ClipRRect(
    borderRadius: BorderRadius.circular(mq.height * .03),
    child: CachedNetworkImage(
      width: mq.height * .05,
      height: mq.height * .05,
      imageUrl: widget.user.image,
      fit: BoxFit.fill,
      errorWidget: (context, url, error) => const CircleAvatar(
        child: Icon(CupertinoIcons.person),
      ),
    ),
        ),
        SizedBox(
    width: 10,
        ),
        Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        widget.user.name,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16),
      ),
      SizedBox(
        height: 5,
      ),
      const Text(
        "Last seen yesterdat 12:46 AM",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 153, 147, 147),
            fontSize: 12),
      )
    ],
        )
      ],
    );
  }
}
