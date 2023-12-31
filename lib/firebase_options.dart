// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBle7GUXZiFhYXNh0hD9sqClYMxgDawlyc',
    appId: '1:1090200470236:web:a0a916a5336d261ee22a19',
    messagingSenderId: '1090200470236',
    projectId: 'chat2gether-48972',
    authDomain: 'chat2gether-48972.firebaseapp.com',
    storageBucket: 'chat2gether-48972.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANcrJkFxsJsyS1gEOVPoUQVBaLfdfPBmA',
    appId: '1:1090200470236:android:df39e96cba9ba1f0e22a19',
    messagingSenderId: '1090200470236',
    projectId: 'chat2gether-48972',
    storageBucket: 'chat2gether-48972.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTUjGuf6nZIYYgYXmDsiHogL5kAgRJkpM',
    appId: '1:1090200470236:ios:39dfa5a4ed2135dae22a19',
    messagingSenderId: '1090200470236',
    projectId: 'chat2gether-48972',
    storageBucket: 'chat2gether-48972.appspot.com',
    androidClientId: '1090200470236-69l40vallkdu5810f91fechckm0cf0sh.apps.googleusercontent.com',
    iosClientId: '1090200470236-nfg38ld5c7tkikba49u4gn57v85qu33l.apps.googleusercontent.com',
    iosBundleId: 'com.example.chattogether',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTUjGuf6nZIYYgYXmDsiHogL5kAgRJkpM',
    appId: '1:1090200470236:ios:f2e0275de7796f76e22a19',
    messagingSenderId: '1090200470236',
    projectId: 'chat2gether-48972',
    storageBucket: 'chat2gether-48972.appspot.com',
    androidClientId: '1090200470236-69l40vallkdu5810f91fechckm0cf0sh.apps.googleusercontent.com',
    iosClientId: '1090200470236-crvdfa6vppm525ip0vvk66rul0jcoh26.apps.googleusercontent.com',
    iosBundleId: 'com.example.chattogether.RunnerTests',
  );
}
