import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyALIJhuuQsFER6oMUc8s33RGh4RMvbB6Ao",
    authDomain: "projekatmobilne-4fa67.firebaseapp.com",
    projectId: "projekatmobilne-4fa67",
    storageBucket: "projekatmobilne-4fa67.firebasestorage.app",
    messagingSenderId: "729730817992",
    appId: "1:729730817992:web:a63a614d7b8ad59217aafd",
    measurementId: "G-H10MDGY9KV",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyALIJhuuQsFER6oMUc8s33RGh4RMvbB6Ao",
    appId: "1:729730817992:android:02f3ef77cb8e083c17aafd",
    messagingSenderId: "729730817992",
    projectId: "projekatmobilne-4fa67",
    storageBucket: "projekatmobilne-4fa67.firebasestorage.app",
  );
}