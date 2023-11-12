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
    apiKey: 'AIzaSyDgj1l9HBCBK8ata3Rx7GHHlv_Vw4FTE9Q',
    appId: '1:936623626438:web:2916b8ea7d8b251fe7dfc7',
    messagingSenderId: '936623626438',
    projectId: 'optibank-5785d',
    authDomain: 'optibank-5785d.firebaseapp.com',
    storageBucket: 'optibank-5785d.appspot.com',
    measurementId: 'G-VYYJGNKMPP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxWzQr2ypuPhJyQLYUOnh3s1lDhGuCZkk',
    appId: '1:936623626438:android:11245928adb18996e7dfc7',
    messagingSenderId: '936623626438',
    projectId: 'optibank-5785d',
    storageBucket: 'optibank-5785d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBr9njhudmgaGmygku9kAupHMc-1q2jhfA',
    appId: '1:936623626438:ios:ef12fdafb5d94327e7dfc7',
    messagingSenderId: '936623626438',
    projectId: 'optibank-5785d',
    storageBucket: 'optibank-5785d.appspot.com',
    iosBundleId: 'com.example.ekart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBr9njhudmgaGmygku9kAupHMc-1q2jhfA',
    appId: '1:936623626438:ios:73118b4662fa693ae7dfc7',
    messagingSenderId: '936623626438',
    projectId: 'optibank-5785d',
    storageBucket: 'optibank-5785d.appspot.com',
    iosBundleId: 'com.example.ekart.RunnerTests',
  );
}