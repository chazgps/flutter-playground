import 'package:firebase_auth_module/login/ui/register_user_page.dart';
import 'package:firebase_auth_module/login/usuario.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constantes.dart' as constantes;
import '../login_authenticator.dart';
import 'campo_entrada.dart';
import 'componentes.dart';
import 'indicador_progresso_widget.dart';
import 'tela_widget.dart';

class LoginPage extends StatefulWidget {
  late final AuthenticationService _autenticador;
  late Function(Usuario) _onLoginSuccess;
  late Function _onLoginFailure;

  LoginPage(
      {Key? key,
      required AuthenticationService authenticator,
      required Function(Usuario) onLoginSuccess,
      required Function onLoginFailure})
      : super(key: key) {
    _autenticador = authenticator;
    _onLoginSuccess = onLoginSuccess;
    _onLoginFailure = onLoginFailure;
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CampoEntradaState> _campoEmailKey;
  late GlobalKey<CampoEntradaState> _campoSenhaKey;
  late ValueNotifier<bool> _exibeAmpulheta;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
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
              mainAxisSize: MainAxisSize.max,
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
                Spacer(flex: 1),
                _getOrientacaoNovoCadastro(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterUserPage(
                        widget._autenticador,
                        onLoginSuccess: widget._onLoginSuccess,
                        onLoginFailure: widget._onLoginFailure,
                      ),
                    ),
                  );
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

    FocusManager.instance.primaryFocus?.unfocus();

    _exibeAmpulheta.value = true;

    //await Future.delayed(Duration(seconds: 3));

    widget._autenticador.login(email, senha).then(_onLogin, onError: _onError);
  }

  Widget _getOpcaoEsqueciSenha() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Esqueci minha senha',
        style: TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_REALCADO),
      ),
    );
  }

  void _onLogin(usuario) {
    _exibeAmpulheta.value = false;

    widget._onLoginSuccess(usuario);
  }

  void _onError(erro) {
    erro = erro.message;

    _exibeAmpulheta.value = false;

    widget._onLoginFailure(erro);
  }
}
