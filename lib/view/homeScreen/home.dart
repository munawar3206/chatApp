import 'package:chattogether/apis/api.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/view/profile_screen.dart';
import 'package:chattogether/view/homeScreen/chat_user_widget.dart/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<ChatUser> list = [];
  @override
  void initState() {
    Apis.getSelfInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat2gether",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.black,
        leading: const Icon(CupertinoIcons.home),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        user:Apis.me,
                      ),
                    ));
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
        },
        child: const Icon(
          Icons.add_comment_rounded,
        ),
      ),
      body: StreamBuilder(
          stream: Apis.getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:

                final data = snapshot.data?.docs;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    [];
         
                if (list.isNotEmpty) {
                  return ListView.builder(
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          User: list[index],
                        );
                      
                      });
                } else {
                  return const Center(
                    child: Text("No Network"),
                  );
                }
            }
          }),
    );
  }
}
