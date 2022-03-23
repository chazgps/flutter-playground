import 'package:firebase_auth_module/login/service/autenticador.dart';
import 'package:flutter/material.dart';

import 'login/service/firebase_autenticador.dart';
import 'login/service/usuario.dart';
import 'login/ui/pages/login_page.dart';
import 'login/ui/widgets/componentes.dart' as ui;
import 'principal_page.dart';
import 'rotas.dart' as rotas;

class MyApp extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  late final Autenticador _autenticador;

  MyApp({Key? key}) : super(key: key) {
    _autenticador = FirebaseAutenticador();
    _autenticador.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        indicatorColor: Colors.tealAccent,
        textTheme: TextTheme(
            bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
            bodyText2: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
      ),
      home: LoginPage(
          authenticator: _autenticador, onLoginSuccess: _irParaTelaPrincipal, onLoginFailure: _exibirMensagemErro),
      onGenerateRoute: _geradorRotas,
    );
  }

  Route<MaterialPageRoute> _geradorRotas(settings) {
    if (settings.name == rotas.PAGINA_PRINCIPAL) {
      return MaterialPageRoute(
        builder: (_) => const PrincipalPage(),
      );
    } else {
      return MaterialPageRoute(
        builder: (_) => Container(color: Colors.white, child: const Text('Página não encontrada')),
      );
    }
  }

  void _irParaTelaPrincipal(Usuario usuario) {
    debugPrint('Navegando para tela principal para o usuário ${usuario.nome}');

    navigatorKey.currentState!.pushReplacementNamed(rotas.PAGINA_PRINCIPAL);
  }

  void _exibirMensagemErro(erro) {
    ui.exibeMensagem(navigatorKey.currentContext!, 'Erro', erro);
  }
}
