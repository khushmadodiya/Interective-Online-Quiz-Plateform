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
    apiKey: 'AIzaSyBDhyYwc_xYjYeN2jHTjioFxgJnlSk7clg',
    appId: '1:240403369452:web:d418f8a8b2480f628884c9',
    messagingSenderId: '240403369452',
    projectId: 'online-quiz-8566e',
    authDomain: 'online-quiz-8566e.firebaseapp.com',
    storageBucket: 'online-quiz-8566e.appspot.com',
    measurementId: 'G-12NMM87T9M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2HRp6dVWbn_1J7LHKSqlKrtYwKRpSq4o',
    appId: '1:240403369452:android:b7a806f73f971f428884c9',
    messagingSenderId: '240403369452',
    projectId: 'online-quiz-8566e',
    storageBucket: 'online-quiz-8566e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSsZpQk7BgsJxv3k-pQjSsIfX4JP2xm-4',
    appId: '1:240403369452:ios:8251a056cf56a7608884c9',
    messagingSenderId: '240403369452',
    projectId: 'online-quiz-8566e',
    storageBucket: 'online-quiz-8566e.appspot.com',
    iosBundleId: 'com.example.quizPlatform',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSsZpQk7BgsJxv3k-pQjSsIfX4JP2xm-4',
    appId: '1:240403369452:ios:8251a056cf56a7608884c9',
    messagingSenderId: '240403369452',
    projectId: 'online-quiz-8566e',
    storageBucket: 'online-quiz-8566e.appspot.com',
    iosBundleId: 'com.example.quizPlatform',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBDhyYwc_xYjYeN2jHTjioFxgJnlSk7clg',
    appId: '1:240403369452:web:77e2004213db11098884c9',
    messagingSenderId: '240403369452',
    projectId: 'online-quiz-8566e',
    authDomain: 'online-quiz-8566e.firebaseapp.com',
    storageBucket: 'online-quiz-8566e.appspot.com',
    measurementId: 'G-397HLZQ52G',
  );

}