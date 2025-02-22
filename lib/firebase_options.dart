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
    apiKey: 'AIzaSyC-QksmvJvBkliS4-WaAiZ4NoxH7XSaghw',
    appId: '1:391948040070:web:1b0e8b8b7f135ff7345e07',
    messagingSenderId: '391948040070',
    projectId: 'voice-app-b7cc2',
    authDomain: 'voice-app-b7cc2.firebaseapp.com',
    storageBucket: 'voice-app-b7cc2.appspot.com',
    measurementId: 'G-3X1EQNBL64',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzI9VquvHemgsLLroJkXsN0uqcpJcr6Nc',
    appId: '1:391948040070:android:89335ecd3d5d7b86345e07',
    messagingSenderId: '391948040070',
    projectId: 'voice-app-b7cc2',
    storageBucket: 'voice-app-b7cc2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQcA78BrL1wNpKM_mxghI_N_OmCApQ0kI',
    appId: '1:391948040070:ios:ecf5f0e5238e4080345e07',
    messagingSenderId: '391948040070',
    projectId: 'voice-app-b7cc2',
    storageBucket: 'voice-app-b7cc2.appspot.com',
    iosBundleId: 'com.example.voice',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQcA78BrL1wNpKM_mxghI_N_OmCApQ0kI',
    appId: '1:391948040070:ios:ecf5f0e5238e4080345e07',
    messagingSenderId: '391948040070',
    projectId: 'voice-app-b7cc2',
    storageBucket: 'voice-app-b7cc2.appspot.com',
    iosBundleId: 'com.example.voice',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-QksmvJvBkliS4-WaAiZ4NoxH7XSaghw',
    appId: '1:391948040070:web:f808fe0a684cc9ba345e07',
    messagingSenderId: '391948040070',
    projectId: 'voice-app-b7cc2',
    authDomain: 'voice-app-b7cc2.firebaseapp.com',
    storageBucket: 'voice-app-b7cc2.appspot.com',
    measurementId: 'G-V7KENV33NR',
  );
}
