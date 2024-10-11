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
        return macos;
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
    apiKey: 'AIzaSyDQpL9iLiSpkahM1Xhh4nPzSBhXhfV0ljY',
    appId: '1:495386290186:web:e48d31848229db1b5857f3',
    messagingSenderId: '495386290186',
    projectId: 'coswan-73d75',
    authDomain: 'coswan-73d75.firebaseapp.com',
    storageBucket: 'coswan-73d75.appspot.com',
    measurementId: 'G-KMQDEPG82E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJb5WXRrIzkU70sP5Dcb3kkv9Ck0epEBE',
    appId: '1:495386290186:android:0b584fea843db9c05857f3',
    messagingSenderId: '495386290186',
    projectId: 'coswan-73d75',
    storageBucket: 'coswan-73d75.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGW3YQAuyvHr0QuGuCqWrOrr8TVQJU37s',
    appId: '1:495386290186:ios:87c114a466aaf77f5857f3',
    messagingSenderId: '495386290186',
    projectId: 'coswan-73d75',
    storageBucket: 'coswan-73d75.appspot.com',
    iosBundleId: 'com.example.coswan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCGW3YQAuyvHr0QuGuCqWrOrr8TVQJU37s',
    appId: '1:495386290186:ios:87c114a466aaf77f5857f3',
    messagingSenderId: '495386290186',
    projectId: 'coswan-73d75',
    storageBucket: 'coswan-73d75.appspot.com',
    iosBundleId: 'com.example.coswan',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDQpL9iLiSpkahM1Xhh4nPzSBhXhfV0ljY',
    appId: '1:495386290186:web:526134d5e276c8515857f3',
    messagingSenderId: '495386290186',
    projectId: 'coswan-73d75',
    authDomain: 'coswan-73d75.firebaseapp.com',
    storageBucket: 'coswan-73d75.appspot.com',
    measurementId: 'G-7JKYLF21SZ',
  );
}