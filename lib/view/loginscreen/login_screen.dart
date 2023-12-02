import 'package:chattogether/helpers/dialogues.dart';

import 'package:chattogether/view/loginscreen/demo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 4, 55, 78),
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              width: mq.width * .5,
              left: mq.width * .25,
              child: Lottie.asset("assets/Animation - 1701407219008 (1).json",
                  height: 300)),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width * .9,
            left: mq.width * .05,
            height: mq.height * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent.shade100,
                  shape: const StadiumBorder(side: BorderSide(width: 3)),
                  elevation: 1),
              onPressed: () {
                handleGoogleBtnClick(context);
              },
              icon: Image.asset(
                "assets/google.png",
                height: mq.height * .03,
              ),
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                        text: "Sign In with ",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(
                        text: "Google",
                        style: TextStyle(fontWeight: FontWeight.w900))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
