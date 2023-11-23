
import 'package:chattogether/apis/api.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/widgets/chat_user_widget.dart/chat_user_card.dart';
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
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
          stream: Apis.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
       
              case ConnectionState.active:
            
              case ConnectionState.done:
               

                // if (snapshot.hasData) {
                final data = snapshot.data?.docs;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    [];
                // for (var i in data!) {
                //   print('Data : ${jsonEncode(i.data())}');
                //   list.add(i.data()['name']);
                // }
                // }
                if (list.isNotEmpty) {
                  return ListView.builder(
                      itemCount: list.length,
                      padding: EdgeInsets.only(top: mq.height * .01),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          User: list[index],
                        );
                        // return Text('Name :${list[index]}');
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
