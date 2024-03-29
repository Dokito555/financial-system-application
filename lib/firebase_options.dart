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
    apiKey: 'AIzaSyBVFYMWbxQWhQGotFucaOrgASy-5UqFO2Y',
    appId: '1:179517236530:web:68feca8ccc3b09d105632b',
    messagingSenderId: '179517236530',
    projectId: 'financial-ab5e8',
    authDomain: 'financial-ab5e8.firebaseapp.com',
    databaseURL: 'https://financial-ab5e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'financial-ab5e8.appspot.com',
    measurementId: 'G-L5CKYRF82T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-M-MeoK-VR6FmrrwHWveIqf2Ue87VRM4',
    appId: '1:179517236530:android:d8a09cbcc617e90105632b',
    messagingSenderId: '179517236530',
    projectId: 'financial-ab5e8',
    databaseURL: 'https://financial-ab5e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'financial-ab5e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUqLRCww3fHqi2XLAU4zfpIWNu3LN_wbw',
    appId: '1:179517236530:ios:3bf085afce5b436b05632b',
    messagingSenderId: '179517236530',
    projectId: 'financial-ab5e8',
    databaseURL: 'https://financial-ab5e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'financial-ab5e8.appspot.com',
    iosClientId: '179517236530-tcvv4dmi79toa5loic90j95tdbsv1n0k.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFinancial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUqLRCww3fHqi2XLAU4zfpIWNu3LN_wbw',
    appId: '1:179517236530:ios:3bf085afce5b436b05632b',
    messagingSenderId: '179517236530',
    projectId: 'financial-ab5e8',
    databaseURL: 'https://financial-ab5e8-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'financial-ab5e8.appspot.com',
    iosClientId: '179517236530-tcvv4dmi79toa5loic90j95tdbsv1n0k.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFinancial',
  );
}
