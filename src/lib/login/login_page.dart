import 'package:firebase_auth_module/login/register_user_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'componentes.dart';
import 'constantes.dart' as constantes;
import 'login_authenticator.dart';
import 'tela_widget.dart';
import 'ui/campo_entrada.dart';

class LoginPage extends StatefulWidget {
  late final AuthenticationService _autenticador;
  late final Function _onSuccess;
  late final Function _onFail;

  LoginPage(
      {Key? key, required AuthenticationService authenticator, required Function onSuccess, required Function onFail})
      : super(key: key) {
    _autenticador = authenticator;
    _onSuccess = onSuccess;
    _onFail = onFail;
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            getLogo(),
            const SizedBox(height: 100),
            getCampoEmail(_campoEmailKey),
            const SizedBox(height: 10),
            getCampoSenha(_campoSenhaKey),
            const SizedBox(height: 10),
            _getOpcaoEsqueciSenha(),
            const SizedBox(height: 30),
            getBotao('Entrar', onTap: () {
              _autenticaUsuario(_campoEmailKey.currentState!.text, _campoSenhaKey.currentState!.text);
            }),
            const Spacer(flex: 1),
            _getOrientacaoNovoCadastro(),
          ],
        ),
      ),
    );
  }

  Widget _getOrientacaoNovoCadastro() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: RichText(
        text: TextSpan(
          text: 'Ainda não é cadastrado ?',
          style: const TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR),
          children: [
            TextSpan(
              text: ' Clique aqui',
              style: const TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_REALCADO),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  debugPrint('Cadastrar nova membro...');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterUserPage()));
                },
            ),
          ],
        ),
      ),
    );
  }

  void _autenticaUsuario(String email, String senha) async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('form com problema');
      return;
    }

    debugPrint('form validado');

    widget._autenticador.login(email, senha).then((value) {
      _campoEmailKey.currentState!.clear();
      _campoSenhaKey.currentState!.clear();
      FocusScope.of(context).unfocus();
      setState(() {});

      widget._onSuccess();
    }, onError: (erro, stackstrace) {
      erro = erro.toString().replaceAll('Exception: ', '');

      widget._onFail(erro);
    });
  }

  Widget _getOpcaoEsqueciSenha() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Esqueci minha senha',
        style: TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_REALCADO),
      ),
    );
  }
}
