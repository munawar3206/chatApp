import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/apis/api.dart';
import 'package:chattogether/main.dart';
import 'package:chattogether/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          label: Text("signout"),
          backgroundColor: const Color.fromARGB(255, 245, 9, 9),
          onPressed: () async {
            await Apis.auth.signOut();
            await GoogleSignIn().signOut();
          },
          icon: Icon(
            Icons.logout_outlined,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: mq.width,
              height: mq.height * .1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .1),
              child: CachedNetworkImage(
                width: mq.height * .2,
                height: mq.height * .2,
                imageUrl: widget.user.image,
                fit: BoxFit.fill,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            Text(widget.user.email),
            SizedBox(
              height: mq.height * .03,
            ),
            TextFormField(
              initialValue: widget.user.name,
              decoration: InputDecoration(
                hintText: "eg. Avarankutty",
                label: const Text("Name"),
                prefixIcon: const Icon(Icons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: mq.height * .03,
            ),
            TextFormField(
              initialValue: widget.user.about,
              decoration: InputDecoration(
                  hintText: "eg. ntha barthanam",
                  label: const Text("About"),
                  prefixIcon: const Icon(Icons.info_outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            ElevatedButton.icon(
                onPressed: () {}, icon: Icon(Icons.edit), label: Text("UPDATE"),)
          ]),
        ),
      ),
    );
  }
}
