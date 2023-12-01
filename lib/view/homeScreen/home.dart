import 'package:chattogether/controller/homeprovider.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/services/services.dart';
import 'package:chattogether/view/loginscreen/login_screen.dart';
import 'package:chattogether/view/profile_screen.dart';
import 'package:chattogether/view/homeScreen/chat_user_widget.dart/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<ChatUser> list = [];
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getSelfInfoProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Send-Chat 🗨️",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 4,
        backgroundColor: Color.fromARGB(255, 4, 55, 78),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            icon: const Icon(CupertinoIcons.home)),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        user: Services.me,
                      ),
                    ));
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider value, Widget? child) {
          return StreamBuilder(
              stream: value.getAllUsersProvider(),
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
                    list = data
                            ?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ??
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
              });
        },
      ),
    );
  }
}
