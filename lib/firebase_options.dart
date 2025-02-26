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
    apiKey: 'AIzaSyAuXuTgXOJ6lVAPn9zLCwCigNtwrptdBnc',
    appId: '1:175343824367:web:60fdf9cae872d45683da1a',
    messagingSenderId: '175343824367',
    projectId: 'expance-manager-6587a',
    authDomain: 'expance-manager-6587a.firebaseapp.com',
    storageBucket: 'expance-manager-6587a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4yXlYTxHr2bU01n-k7fcmAMypQDDDVEw',
    appId: '1:175343824367:android:5d219ddaf3d6732e83da1a',
    messagingSenderId: '175343824367',
    projectId: 'expance-manager-6587a',
    storageBucket: 'expance-manager-6587a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM0bpIZMhMSqcaZbu7Bn570Up_73yZ338',
    appId: '1:175343824367:ios:f3bbf300cd74076383da1a',
    messagingSenderId: '175343824367',
    projectId: 'expance-manager-6587a',
    storageBucket: 'expance-manager-6587a.firebasestorage.app',
    iosBundleId: 'com.example.expanceManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCM0bpIZMhMSqcaZbu7Bn570Up_73yZ338',
    appId: '1:175343824367:ios:f3bbf300cd74076383da1a',
    messagingSenderId: '175343824367',
    projectId: 'expance-manager-6587a',
    storageBucket: 'expance-manager-6587a.firebasestorage.app',
    iosBundleId: 'com.example.expanceManager',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAuXuTgXOJ6lVAPn9zLCwCigNtwrptdBnc',
    appId: '1:175343824367:web:ea33ea8a2715ffb983da1a',
    messagingSenderId: '175343824367',
    projectId: 'expance-manager-6587a',
    authDomain: 'expance-manager-6587a.firebaseapp.com',
    storageBucket: 'expance-manager-6587a.firebasestorage.app',
  );
}
