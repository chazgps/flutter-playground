import 'package:flutter/material.dart';

import '../../service/autenticador.dart';
import '../constantes.dart' as constantes;
import '../widgets/campo_entrada.dart';
import '../widgets/componentes.dart' as ui;
import '../widgets/indicador_progresso_widget.dart';
import '../widgets/tela_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  late final Autenticador _autenticador;

  ResetPasswordPage(Autenticador authenticator, {Key? key}) : super(key: key) {
    _autenticador = authenticator;
  }

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CampoEntradaState> _campoEmailKey;
  late ValueNotifier<bool> _exibeAmpulheta;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _campoEmailKey = GlobalKey<CampoEntradaState>();

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
                  ui.getPainel(context, 'Esqueceu a senha ?'),
                  _getOrientacao(),
                  ui.getCampoEmail(_campoEmailKey),
                  ui.getBotao(
                    'Enviar e-mail',
                    onTap: () {
                      _resetaSenha(_campoEmailKey.currentState!.text);
                    },
                  ),
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

  void _resetaSenha(String email) async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('form com problema');
      return;
    }

    debugPrint('form validado');

    FocusManager.instance.primaryFocus?.unfocus();

    _exibeAmpulheta.value = true;

    //await Future.delayed(Duration(seconds: 3));

    widget._autenticador.resetaSenha(email).then(_onSuccess, onError: _onError);
  }

  Widget _getOrientacao() {
    const String mensagem =
        'Não se preocupe, isso pode acontecer as vezes. Indique seu endereço de e-mail usado na sua conta e '
        'enviaremos um e-mail para que você possa cadastrar uma nova senha.';

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mensagem,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: constantes.TAMANHO_FONTE_ORIENTACAO_CORPO),
          ),
        ],
      ),
    );
  }

  void _onSuccess(usuario) {
    _exibeAmpulheta.value = false;

    const String titulo = 'Atenção';
    const String mensagem = 'Um e-mail foi enviado para o endereço fornecido.\n\n'
        'Clique no link e cadastre uma nova senha !';

    ui.exibeMensagem(context, titulo, mensagem).then((value) => Navigator.pop(context));
  }

  void _onError(erro) {
    erro = erro.message;

    _exibeAmpulheta.value = false;

    ui.exibeMensagem(context, 'Erro', erro);
  }
}
