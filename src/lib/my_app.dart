import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/google_authenticator.dart';
import 'login/login_page.dart';
import 'principal_page.dart';
import 'rotas.dart' as rotas;

class MyApp extends StatelessWidget {
  late FirebaseAuth _firebaseAuth;
  final navigatorKey = GlobalKey<NavigatorState>();

  MyApp({Key? key, required FirebaseAuth firebaseAuth}) : super(key: key) {
    _firebaseAuth = firebaseAuth;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
          authenticator: GoogleAuthenticator(_firebaseAuth),
          onSuccess: () {
            navigatorKey.currentState!.pushNamed(rotas.PAGINA_PRINCIPAL);
          },
          onFail: (String erro) {
            showDialog(
              context: navigatorKey.currentContext!,
              builder: (BuildContext context) => AlertDialog(
                insetPadding: EdgeInsets.all(20),
                contentPadding: EdgeInsets.all(20),
                title: Text('Erro'),
                content: Text(erro),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          }),
      onGenerateRoute: (settings) {
        if (settings.name == rotas.PAGINA_PRINCIPAL) {
          return MaterialPageRoute(
            builder: (_) => const PrincipalPage(),
          );
        }
      },
    );
  }
}
