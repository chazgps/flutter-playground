import 'package:firebase_auth_module/login/login_authenticator.dart';
import 'package:flutter/material.dart';

import 'login/google_authenticator.dart';
import 'login/ui/login_page.dart';
import 'login/usuario.dart';
import 'principal_page.dart';
import 'rotas.dart' as rotas;

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  late AuthenticationService _authService;

  MyApp({Key? key}) : super(key: key) {
    _authService = GoogleAuthenticator();
    _authService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
          authenticator: _authService, onLoginSuccess: _irParaTelaPrincipal, onLoginFailure: _exibeMensagemErro),
      onGenerateRoute: (settings) {
        if (settings.name == rotas.PAGINA_PRINCIPAL) {
          return MaterialPageRoute(
            builder: (_) => const PrincipalPage(),
          );
        }
      },
    );
  }

  void _irParaTelaPrincipal(Usuario usuario) {
    debugPrint('Navegando para tela principal');

    navigatorKey.currentState!.pushReplacementNamed(rotas.PAGINA_PRINCIPAL);
  }

  void _exibeMensagemErro(String erro) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        contentPadding: const EdgeInsets.all(20),
        title: const Text('Erro'),
        content: Text(erro),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
