import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyD9Efd_n2PQ1qqeTxwengQz0Cw6LD6i8TA',
    appId: '1:738954420065:android:e04e0a7b1fb75784976f20',
    messagingSenderId: '738954420065',
    projectId: 'bmi-task-60081',
    storageBucket: 'bmi-task-60081.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAki0q0QfU_Qc7lDAqOR8Rxk9QwPgQxaRg',
    appId: '1:607140931138:ios:cb449428d1d7ef8e642fdb',
    messagingSenderId: '607140931138',
    projectId: 'test-2c3c8',
    storageBucket: 'test-2c3c8.appspot.com',
    androidClientId: '607140931138-9d083j4j7sg0tnnuqgdl99p3dkgn5qjm.apps.googleusercontent.com',
    iosClientId: 'com.googleusercontent.apps.406099696497-l9gojfp6b3h1cgie1se28a9ol9fmsvvk',
    iosBundleId: 'com.example.notes',
  );
}
