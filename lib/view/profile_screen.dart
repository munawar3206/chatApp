import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattogether/controller/profilrprovider.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/model/model.dart';
import 'package:chattogether/services/services.dart';
import 'package:chattogether/view/loginscreen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final ChatUser user;
  ProfileScreen({super.key, required this.user});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileprovider = Provider.of<ProfileProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 4,
          backgroundColor: const Color.fromARGB(255, 3, 90, 90),
          toolbarHeight: 75,
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
              await Services.auth.signOut().then((value) async {
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
                    profileprovider.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(mq.height * .1),
                            child: Image.file(
                              File(profileprovider.image!),
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
                              imageUrl: user.image,
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
                          _showbottomsheet(context);
                        },
                        color: Colors.white,
                        elevation: 1,
                        child: const Icon(
                          Icons.edit,
                          color: const Color.fromARGB(255, 3, 90, 90),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: mq.height * .03,
                ),
                Text(user.email),
                SizedBox(
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: user.name,
                  onSaved: (val) => Services.me.name = val ?? "",
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
                  initialValue: user.about,
                  onSaved: (val) => Services.me.about = val ?? "",
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : "Required Field",
                  decoration: InputDecoration(
                      hintText: "eg. ntha barthanam",
                      label: const Text("About"),
                      prefixIcon: const Icon(Icons.info_outline,
                          color: const Color.fromARGB(255, 3, 90, 90)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      profileprovider.updateUserInfoProvider().then(
                          (value) => Dialogs.showSnackbar(context, 'Updated'));
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

  void _showbottomsheet(context) {
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
                            backgroundColor:
                                const Color.fromARGB(255, 3, 90, 90),
                            fixedSize: Size(mq.width * .3, mq.height * .14)),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
// Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 80);
                          if (image != null) {
                            print(
                                "image path : ${image.path} --MimeType:${image.mimeType}");
                            // setState(() {
                            //   _image = image.path;
                            // });
                            final profileProvider =
                                Provider.of<ProfileProvider>(context,
                                    listen: false);
                            profileProvider.imageValueChange(image.path);

                            Services.updateProfilePicture(
                                File(profileProvider.image!));
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
                            backgroundColor:
                                const Color.fromARGB(255, 3, 90, 90),
                            fixedSize: Size(mq.width * .3, mq.height * .14)),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
// Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera, imageQuality: 80);
                          if (image != null) {
                            print(
                                "image path : ${image.path} --MimeType:${image.mimeType}");
                            final profileProvider =
                                Provider.of<ProfileProvider>(context);
                            profileProvider.imageValueChange(image.path);
                            Services.updateProfilePicture(
                                File(profileProvider.image!));
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
