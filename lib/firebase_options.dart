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
    apiKey: 'AIzaSyAnWcqu758uVnUQ_1DC5nYOEBiqIJGJQ1U',
    appId: '1:624229847509:web:83ac7a99cedc86c5c5ad5c',
    messagingSenderId: '624229847509',
    projectId: 'my-ngo-pledges',
    authDomain: 'my-ngo-pledges.firebaseapp.com',
    storageBucket: 'my-ngo-pledges.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnWcqu758uVnUQ_1DC5nYOEBiqIJGJQ1U',
    appId: '1:624229847509:android:83ac7a99cedc86c5c5ad5c',
    messagingSenderId: '624229847509',
    projectId: 'my-ngo-pledges',
    storageBucket: 'my-ngo-pledges.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnWcqu758uVnUQ_1DC5nYOEBiqIJGJQ1U',
    appId: '1:624229847509:ios:83ac7a99cedc86c5c5ad5c',
    messagingSenderId: '624229847509',
    projectId: 'my-ngo-pledges',
    storageBucket: 'my-ngo-pledges.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnWcqu758uVnUQ_1DC5nYOEBiqIJGJQ1U',
    appId: '1:624229847509:macos:83ac7a99cedc86c5c5ad5c',
    messagingSenderId: '624229847509',
    projectId: 'my-ngo-pledges',
    storageBucket: 'my-ngo-pledges.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnWcqu758uVnUQ_1DC5nYOEBiqIJGJQ1U',
    appId: '1:624229847509:windows:83ac7a99cedc86c5c5ad5c',
    messagingSenderId: '624229847509',
    projectId: 'my-ngo-pledges',
    storageBucket: 'my-ngo-pledges.firebasestorage.app',
  );
}
