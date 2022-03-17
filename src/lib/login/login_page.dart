import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'constantes.dart' as constantes;
import 'login_authenticator.dart';

class LoginPage extends StatefulWidget {
  late final LoginAuthenticator _autenticador;
  late final Function _onSuccess;
  late final Function _onFail;

  LoginPage(
      {Key? key, required LoginAuthenticator authenticator, required Function onSuccess, required Function onFail})
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
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  late FocusNode _focusNodeLogin;
  late FocusNode _focusNodeSenha;
  late bool _senhaVisivel;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _focusNodeLogin = FocusNode();
    _focusNodeSenha = FocusNode();
    _senhaVisivel = false;
  }

  @override
  void dispose() {
    _focusNodeLogin.dispose();
    _focusNodeSenha.dispose();
    _loginController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.indigo,
                  ],
                ),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Theme(
                    data: ThemeData(
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.white),
                        iconColor: Colors.white,
                        errorStyle:
                            TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_ERRO),
                      ),
                    ),
                    child: Column(
                      children: [
                        _getLogo(),
                        const SizedBox(height: 100),
                        _getCampoLogin(context),
                        const SizedBox(height: 10),
                        _getCampoSenha(),
                        const SizedBox(height: 10),
                        _getOpcaoEsqueciSenha(),
                        const SizedBox(height: 30),
                        _getBotaoEntrar(),
                        const Spacer(flex: 1),
                        _getOrientacaoNovoCadastro(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getCampoLogin(BuildContext context) {
    return _getTextField(
      label: 'Login',
      controller: _loginController,
      focus: _focusNodeLogin,
      validatorFunction: (valor) {
        if (valor == null || valor.isEmpty) {
          FocusScope.of(context).requestFocus(_focusNodeLogin);
          return 'O login não pode ser vazio !';
        } else {
          return null;
        }
      },
    );
  }

  _getCampoSenha() {
    return _getTextField(
        label: 'Senha',
        controller: _passwordController,
        focus: _focusNodeSenha,
        inputAction: TextInputAction.done,
        validatorFunction: (String? valor) {
          if (valor == null || valor.isEmpty) {
            FocusScope.of(context).requestFocus(_focusNodeSenha);
            return 'A senha não pode ser vazia !';
          } else {
            return null;
          }
        },
        campoDeSenha: true);
  }

  SizedBox _getLogo() {
    return const SizedBox(
      height: 100,
      width: 200,
      child: Placeholder(
        color: Colors.red,
      ),
    );
  }

  Widget _getOrientacaoNovoCadastro() {
    return Padding(
      padding: const EdgeInsets.only(top: 70),
      child: RichText(
        text: TextSpan(
          text: 'Ainda não é cadastrado ?',
          style: const TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR),
          children: [
            TextSpan(
              text: ' Clique aqui',
              style: const TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_REALCADO),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint('Cadastrar novo membro...');
                },
            ),
          ],
        ),
      ),
    );
  }

  _getTextField(
      {required String label,
      required TextEditingController controller,
      required FocusNode focus,
      TextInputAction inputAction = TextInputAction.next,
      required Function(String?) validatorFunction,
      campoDeSenha = false}) {
    return TextFormField(
      controller: controller,
      focusNode: focus,
      obscureText: campoDeSenha && !_senhaVisivel,
      onTap: () {
        setState(() {});
      },
      onChanged: (String? valor) {
        setState(() {});
      },
      style: const TextStyle(
        color: Colors.white,
        fontSize: constantes.TAMANHO_FONTE_CAMPO_ENTRADA,
      ),
      scrollPadding: const EdgeInsets.only(bottom: 200),
      textInputAction: inputAction,
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: constantes.COR_BORDA),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: constantes.COR_BORDA_ERRO),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: constantes.COR_BORDA_ERRO),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: constantes.COR_BORDA_ERRO, width: 2.0),
        ),
        suffixIcon: _getSuffixIcon(controller, campoDeSenha),
      ),
      onFieldSubmitted: (v) {
        focus.nextFocus();
      },
      validator: (String? value) {
        return validatorFunction(value);
      },
    );
  }

  Widget _getSuffixIcon(TextEditingController controller, bool obscureText) {
    if (obscureText) {
      return _getSuffixIconObscure();
    } else {
      return Visibility(
        visible: controller.text.isNotEmpty,
        child: IconButton(
          iconSize: 16.0,
          icon: const Icon(Icons.close),
          onPressed: () {
            controller.clear();
            // Remove o icone de limpar o campo
            setState(() {});
          },
        ),
      );
    }
  }

  Widget _getSuffixIconObscure() {
    return IconButton(
      iconSize: 16.0,
      icon: _senhaVisivel ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
      onPressed: () {
        setState(() {
          _senhaVisivel = !_senhaVisivel;
        });
      },
    );
  }

  Widget _getBotaoEntrar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          autenticaUsuario(_loginController.text, _passwordController.text);
        },
        child: const Text('Entrar'),
      ),
    );
  }

  void autenticaUsuario(String login, String senha) async {
    if (!_formKey.currentState!.validate()) {
      debugPrint('form com problema');
      return;
    }

    debugPrint('form validado');

    widget._autenticador.authenticate(login, senha).then((value) {
      _loginController.clear();
      _passwordController.clear();
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
