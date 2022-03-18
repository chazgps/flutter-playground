import 'package:flutter/material.dart';

import 'componentes.dart';
import 'tela_widget.dart';
import 'ui/campo_entrada.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CampoEntradaState> _campoEmailKey;
  late GlobalKey<CampoEntradaState> _campoSenhaKey;

  late CampoEntrada _campoEmail;
  late CampoEntrada _campoSenha;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _campoEmailKey = GlobalKey<CampoEntradaState>();
    _campoEmail = getCampoEmail(_campoEmailKey);

    _campoSenhaKey = GlobalKey<CampoEntradaState>();
    _campoSenha = getCampoSenha(_campoSenhaKey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tela(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            _getLogo(),
            const SizedBox(height: 100),
            getCampoEmail(_campoEmailKey),
            const SizedBox(height: 10),
            getCampoSenha(_campoSenhaKey),
            const SizedBox(height: 30),
            getBotao('Cadastrar', onTap: () {})
          ],
        ),
      ),
    );
  }

  Widget _getLogo() {
    return const SizedBox(
      height: 100,
      width: 200,
      child: Placeholder(
        color: Colors.red,
      ),
    );
  }
}
