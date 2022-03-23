import 'package:firebase_auth_module/login/service/usuario.dart';
import 'package:flutter/material.dart';

import '../../service/authenticator.dart';
import '../constantes.dart' as constantes;
import '../widgets/campo_entrada.dart';
import '../widgets/componentes.dart' as ui;
import '../widgets/indicador_progresso_widget.dart';
import '../widgets/tela_widget.dart';

class RegisterUserPage extends StatefulWidget {
  late final Autenticador _autenticador;
  late final Function(Usuario) _onLoginSuccess;
  late final Function _onLoginFailure;

  RegisterUserPage(Autenticador autenticador,
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
            child: Padding(
              padding: const EdgeInsets.only(left: constantes.ESPACO_BORDA, right: constantes.ESPACO_BORDA),
              child: Column(
                children: [
                  ui.getPainel(context, 'Cadastre-se !'),
                  ui.getCampoNome(_campoNomeKey),
                  ui.getCampoEmail(_campoEmailKey),
                  ui.getCampoSenha(_campoSenhaKey),
                  ui.getBotao('Cadastrar', onTap: () {
                    _cadastraUsuario(context, _campoNomeKey.currentState!.text, _campoEmailKey.currentState!.text,
                        _campoSenhaKey.currentState!.text);
                  })
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

  void _cadastraUsuario(BuildContext context, String nome, String email, String senha) async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('form com problema');
      return;
    }

    debugPrint('form validado');

    FocusManager.instance.primaryFocus?.unfocus();

    _exibeAmpulheta.value = true;

    //await Future.delayed(const Duration(seconds: 3));

    widget._autenticador.cadastrarUsuario(nome, email, senha).then(_onSuccess, onError: _onError);
  }

  void _onSuccess(usuario) {
    _exibeAmpulheta.value = false;

    widget._onLoginSuccess(usuario);
  }

  void _onError(erro) {
    erro = erro.message;

    _exibeAmpulheta.value = false;

    widget._onLoginFailure(erro);
  }
}
