import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/apis/api.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/view/loginscreen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
            label: const Text("Logout"),
            backgroundColor: const Color.fromARGB(255, 245, 9, 9),
            onPressed: () async {
              // progress dialog
              Dialogs.showProgressBar(context);
              // signout
              await Apis.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) => {
                      // hidding progress bar
                      Navigator.pop(context),
                      Navigator.pop(context),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ))
                    });
              });
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * .1,
                ),
                Stack(
                  children: [
                    _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height * .1),
                            child: Image.file(
                              File(_image!),
                              width: mq.height * .2,
                              height: mq.height * .2,
                              fit: BoxFit.fill,
                             
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height * .1),
                            child: CachedNetworkImage(
                              width: mq.height * .2,
                              height: mq.height * .2,
                              imageUrl: widget.user.image,
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ),
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        onPressed: () {
                          _showbottomsheet();
                        },
                        color: Colors.white,
                        elevation: 1,
                        child: const Icon(Icons.edit),
                      ),
                    )
                  ],
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
                  onSaved: (val) => Apis.me.name = val ?? "",
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                    hintText: "eg. Avarankutty",
                    label: const Text("Name"),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: widget.user.about,
                  onSaved: (val) => Apis.me.about = val ?? "",
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      hintText: "eg. ntha barthanam",
                      label: const Text("About"),
                      prefixIcon: const Icon(Icons.info_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Apis.updateUserInfo()
                          .then((value) => Dialogs.showSnackbar(context,'Updated'));
                      print("valid");
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("UPDATE"),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _showbottomsheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Pick Image From",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            elevation: 20,
                            backgroundColor: Colors.white,
                            fixedSize: Size(mq.width * .3, mq.height * .14)),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
// Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 80);
                          if (image != null) {
                            print(
                                "image path : ${image.path} --MimeType:${image.mimeType}");
                            setState(() {
                              _image = image.path;
                            });
                            Apis.updateProfilePicture(File(_image!));
                          }
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/picture.png",

                          // height: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Gallery",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            elevation: 20,
                            backgroundColor: Colors.white,
                            fixedSize: Size(mq.width * .3, mq.height * .14)),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
// Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 80);
                          if (image != null) {
                            print(
                                "image path : ${image.path} --MimeType:${image.mimeType}");
                            setState(() {
                              _image = image.path;
                            });
                            Apis.updateProfilePicture(File(_image!));
                          }
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/camera.png",

                          // height: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}
