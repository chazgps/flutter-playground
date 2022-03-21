import 'package:firebase_auth_module/login/usuario.dart';
import 'package:flutter/material.dart';

import '../login_authenticator.dart';
import 'campo_entrada.dart';
import 'componentes.dart';
import 'indicador_progresso_widget.dart';
import 'tela_widget.dart';

class RegisterUserPage extends StatefulWidget {
  late final AuthenticationService _autenticador;
  late Function(Usuario) _onLoginSuccess;
  late Function _onLoginFailure;

  RegisterUserPage(AuthenticationService autenticador,
      {Key? key, required Function(Usuario) onLoginSuccess, required Function onLoginFailure})
      : super(key: key) {
    _autenticador = autenticador;
    _onLoginSuccess = onLoginSuccess;
    _onLoginFailure = onLoginFailure;
  }

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CampoEntradaState> _campoNomeKey;
  late GlobalKey<CampoEntradaState> _campoEmailKey;
  late GlobalKey<CampoEntradaState> _campoSenhaKey;
  late ValueNotifier<bool> _exibeAmpulheta;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _campoNomeKey = GlobalKey<CampoEntradaState>();
    _campoEmailKey = GlobalKey<CampoEntradaState>();
    _campoSenhaKey = GlobalKey<CampoEntradaState>();

    _exibeAmpulheta = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Tela(
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                getLogo(),
                const SizedBox(height: 100),
                getCampoNome(_campoNomeKey),
                const SizedBox(height: 10),
                getCampoEmail(_campoEmailKey),
                const SizedBox(height: 10),
                getCampoSenha(_campoSenhaKey),
                const SizedBox(height: 30),
                getBotao('Cadastrar', onTap: () {
                  _cadastraUsuario(context, _campoNomeKey.currentState!.text, _campoEmailKey.currentState!.text,
                      _campoSenhaKey.currentState!.text);
                })
              ],
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _exibeAmpulheta,
          builder: (BuildContext context, bool valor, Widget? child) {
            return IndicadorProgresso(visivel: _exibeAmpulheta.value);
          },
        ),
      ],
    );
  }

  void _cadastraUsuario(BuildContext context, String nome, String email, String senha) async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('form com problema');
      return;
    }

    debugPrint('form validado');

    FocusManager.instance.primaryFocus?.unfocus();

    _exibeAmpulheta.value = true;

    await Future.delayed(Duration(seconds: 3));

    widget._autenticador.cadastrarUsuario(nome, email, senha).then((usuario) {
      _exibeAmpulheta.value = false;

      widget._onLoginSuccess(usuario);
    }, onError: _onError);
  }

  void _onError(erro) {
    erro = erro.message;

    _exibeAmpulheta.value = false;

    widget._onLoginFailure(erro);
  }
}
