import 'package:firebase_auth_module/login/ui/pages/register_user_page.dart';
import 'package:firebase_auth_module/login/ui/pages/reset_password_page.dart';
import 'package:firebase_auth_module/login/usuario.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constantes.dart' as constantes;
import '../../login_authenticator.dart';
import '../widgets/campo_entrada.dart';
import '../widgets/componentes.dart' as ui;
import '../widgets/indicador_progresso_widget.dart';
import '../widgets/tela_widget.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(left: constantes.ESPACO_BORDA, right: constantes.ESPACO_BORDA),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ui.getPainel(context, 'Bem-Vindo !'),
                  ui.getCampoEmail(_campoEmailKey),
                  ui.getCampoSenha(_campoSenhaKey),
                  _getOpcaoEsqueciSenha(),
                  ui.getBotao('Entrar', onTap: () {
                    _autenticaUsuario(_campoEmailKey.currentState!.text, _campoSenhaKey.currentState!.text);
                  }),
                  const Spacer(flex: 1),
                  _getOrientacaoNovoCadastro(),
                ],
              ),
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
      padding: const EdgeInsets.only(top: 20, bottom: 20),
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

    //await Future.delayed(const Duration(seconds: 3));

    widget._autenticador.login(email, senha).then(_onLogin, onError: _onError);
  }

  Widget _getOpcaoEsqueciSenha() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          debugPrint('Indicar email para resetar a senha...');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordPage(widget._autenticador),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            'Esqueci minha senha',
            style: TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_REALCADO),
          ),
        ),
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
