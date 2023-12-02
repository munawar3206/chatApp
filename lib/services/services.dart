import 'dart:io';

import 'package:chattogether/model/message_model.dart';
import 'package:chattogether/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Services { 
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static late ChatUser me;

  static User get user => auth.currentUser!;


 
   
// user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // create new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Chatuser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(Chatuser.toJson());
  }

// getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return Services.firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

// update user info
  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

// update profile pic
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split(".").last;
    print('Extension :$ext');
    final ref = storage.ref().child('ProfilePicture/${user.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred:${p0.bytesTransferred / 1000} kb');
    });
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('user')
        .doc(user.uid)
        .update({'image': me.image});
  }

  ///***************Chat Screen Related Apis/Functions*******************************
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? "${user.uid}_$id"
      : "${id}_${user.uid}";

  // for conversation in database msg

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/message/')
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
  // for seanding message

  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    // message send time
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    // message to send
    final MessageModel message = MessageModel(
        msg: msg,
        toId: chatUser.id,
        read: "",
        type: type,
        fromId: user.uid,
        sent: time);
    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/message/');
    await ref.doc(time).set(message.toJson());
  }

  // update read status of message

  static Future<void> updateMessageReadStatus(MessageModel message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/message/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // get only last message
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/message/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // sent chat image
  static Future<void> sentChatMessage(ChatUser chatUser, File file) async {
    final ext = file.path.split(".").last;
    print('Extension :$ext');
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    // upload
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred:${p0.bytesTransferred / 1000} kb');
    });
    // updating in firebase
    final imageUrl = await ref.getDownloadURL();
    await Services.sendMessage(chatUser, imageUrl, Type.image);
  }

  // static Future<void> deleteMessage(MessageModel message) async {
  //   await firestore
  //       .collection('chats/${getConversationID(message.toId)}/messages/')
  //       .doc(message.sent)
  //       .delete();

  //   if (message.type == Type.image) {
  //     await storage.refFromURL(message.msg).delete();
  //   }
  // }
  
}
