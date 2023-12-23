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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCga4TJjz-5Wi0vuXLVWxVAQEU7g6a9e50',
    appId: '1:444286982103:android:f2ce2026b883c75c08dd92',
    messagingSenderId: '444286982103',
    projectId: 'hospital-appointment-cb651',
    databaseURL: 'https://hospital-appointment-cb651-default-rtdb.firebaseio.com',
    storageBucket: 'hospital-appointment-cb651.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDChpEvcJkUnXSsF3EynWRUfQB9TpOqZXA',
    appId: '1:444286982103:ios:e06a701b756e729708dd92',
    messagingSenderId: '444286982103',
    projectId: 'hospital-appointment-cb651',
    databaseURL: 'https://hospital-appointment-cb651-default-rtdb.firebaseio.com',
    storageBucket: 'hospital-appointment-cb651.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );
}
