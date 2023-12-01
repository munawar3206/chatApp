import 'dart:io';

import 'package:chattogether/controller/profilrprovider.dart';
import 'package:chattogether/helpers/dialogues.dart';
import 'package:chattogether/services/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

void showbottomsheet(context) {
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