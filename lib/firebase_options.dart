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
    apiKey: 'AIzaSyCihjgBjXoQjnketzFqsRi7ZoZ2GABVIgQ',
    appId: '1:793854001670:web:65582bffa3d5e0f1c7b987',
    messagingSenderId: '793854001670',
    projectId: 'ads-chat-610de',
    authDomain: 'ads-chat-610de.firebaseapp.com',
    storageBucket: 'ads-chat-610de.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS9faVPuShWB9C4FkT-pwCh398KIHYss4',
    appId: '1:793854001670:android:fee980604da083bac7b987',
    messagingSenderId: '793854001670',
    projectId: 'ads-chat-610de',
    storageBucket: 'ads-chat-610de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2CSqoFgtRgA9vSu4438xblIR-s2TnlFQ',
    appId: '1:455718635069:ios:b3f18d622f9a9675354c54',
    messagingSenderId: '455718635069',
    projectId: 'ads-chat-34021',
    storageBucket: 'ads-chat-34021.appspot.com',
    iosClientId: '455718635069-92rabi1u4ikp722kco95eae9o467ldqd.apps.googleusercontent.com',
    iosBundleId: 'com.example.adsChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2CSqoFgtRgA9vSu4438xblIR-s2TnlFQ',
    appId: '1:455718635069:ios:b3f18d622f9a9675354c54',
    messagingSenderId: '455718635069',
    projectId: 'ads-chat-34021',
    storageBucket: 'ads-chat-34021.appspot.com',
    iosClientId: '455718635069-92rabi1u4ikp722kco95eae9o467ldqd.apps.googleusercontent.com',
    iosBundleId: 'com.example.adsChat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCIVowLNri4mvjTR_0RtUKXbJ2TO8-V2Hs',
    appId: '1:455718635069:web:d02239cfd91c5a8c354c54',
    messagingSenderId: '455718635069',
    projectId: 'ads-chat-34021',
    authDomain: 'ads-chat-34021.firebaseapp.com',
    storageBucket: 'ads-chat-34021.appspot.com',
  );
}