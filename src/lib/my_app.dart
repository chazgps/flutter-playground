import 'package:firebase_auth_module/login/login_authenticator.dart';
import 'package:flutter/material.dart';

import 'login/google_authenticator.dart';
import 'login/ui/pages/login_page.dart';
import 'login/ui/widgets/componentes.dart' as ui;
import 'login/usuario.dart';
import 'principal_page.dart';
import 'rotas.dart' as rotas;

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  late final AuthenticationService _authService;

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
        indicatorColor: Colors.tealAccent,
        textTheme: TextTheme(
            bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
            bodyText2: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
      ),
      home: LoginPage(
          authenticator: _authService,
          onLoginSuccess: _irParaTelaPrincipal,
          onLoginFailure: (erro) {
            ui.exibeMensagem(navigatorKey.currentContext!, 'Erro', erro);
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

  void _irParaTelaPrincipal(Usuario usuario) {
    debugPrint('Navegando para tela principal para o usuário ${usuario.nome}');

    navigatorKey.currentState!.pushReplacementNamed(rotas.PAGINA_PRINCIPAL);
  }
}
