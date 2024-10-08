// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBJnKmRzU4B1W_nqWDYOwWcNMXAnT6gf9A',
    appId: '1:699987766114:web:72efa88ade87261c415a3b',
    messagingSenderId: '699987766114',
    projectId: 'deje-selam',
    authDomain: 'deje-selam.firebaseapp.com',
    storageBucket: 'deje-selam.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtrAmqHaXXTLh8JrKs-uHokvMXK4UqcTg',
    appId: '1:699987766114:android:a9a826d9fa22e859415a3b',
    messagingSenderId: '699987766114',
    projectId: 'deje-selam',
    storageBucket: 'deje-selam.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUZhlvPpYF1eDiycbJ-TWYnBAiin48ID0',
    appId: '1:699987766114:ios:d751180dc29dfdec415a3b',
    messagingSenderId: '699987766114',
    projectId: 'deje-selam',
    storageBucket: 'deje-selam.appspot.com',
    iosBundleId: 'com.example.zehadis',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBJnKmRzU4B1W_nqWDYOwWcNMXAnT6gf9A',
    appId: '1:699987766114:web:9dad6f7515a211d5415a3b',
    messagingSenderId: '699987766114',
    projectId: 'deje-selam',
    authDomain: 'deje-selam.firebaseapp.com',
    storageBucket: 'deje-selam.appspot.com',
  );

}