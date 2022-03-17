import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseApp firebaseApp = await initFirebase();

  FirebaseAuth auth = await initFirebaseAuth(firebaseApp);

  runApp(MyApp(firebaseAuth: auth));
}

Future<FirebaseApp> initFirebase() async {
  FirebaseApp firebaseApp = await Firebase.initializeApp();

  final List<FirebaseApp> apps = Firebase.apps;
  debugPrint('Currently initialized apps: $apps');

  final FirebaseOptions options = firebaseApp.options;
  debugPrint('Current options for app: $options');

  return firebaseApp;
}

Future<FirebaseAuth> initFirebaseAuth(FirebaseApp firebaseApp) async {
  FirebaseAuth auth = FirebaseAuth.instanceFor(app: firebaseApp);

  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      debugPrint('authStateChanges: User is currently signed out!');
    } else {
      debugPrint('authStateChanges: User is signed in!');
    }
  });

  auth.idTokenChanges().listen((User? user) {
    if (user == null) {
      debugPrint('idTokenChanges: User is currently signed out!');
    } else {
      debugPrint('idTokenChanges: User is signed in!');
    }
  });

  auth.userChanges().listen((User? user) {
    if (user == null) {
      debugPrint('userChanges: User is currently signed out!');
    } else {
      debugPrint('userChanges: User is signed in!');
    }
  });

  return auth;
}
