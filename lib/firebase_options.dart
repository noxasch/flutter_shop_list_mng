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
    apiKey: 'AIzaSyB3-zQ2j5gHcxL3uG7mJeGSBleCWpL-n7g',
    appId: '1:918439754657:android:7d2e7ff72c9358159469e0',
    messagingSenderId: '918439754657',
    projectId: 'shopping-list-dev-eadf3',
    storageBucket: 'shopping-list-dev-eadf3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyl6SA2xRU57XDYzwTI6o4dAVsorpWYik',
    appId: '1:918439754657:ios:8afc84e33f8ae99e9469e0',
    messagingSenderId: '918439754657',
    projectId: 'shopping-list-dev-eadf3',
    storageBucket: 'shopping-list-dev-eadf3.appspot.com',
    iosClientId: '918439754657-kcmq42cb5n696o2lv7djfeop20qanskh.apps.googleusercontent.com',
    iosBundleId: 'tech.noxasch.TodoApp.dev',
  );
}
