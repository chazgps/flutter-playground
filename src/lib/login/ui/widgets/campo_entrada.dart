import 'package:flutter/material.dart';

import '../constantes.dart' as constantes;

class CampoEntrada extends StatefulWidget {
  late final String _label;
  late final TextInputType _inputType;
  late final TextInputAction _inputAction;
  late final Function(String?) _validatorFunction;
  late final bool _campoDeSenha;

  CampoEntrada(
      {Key? key,
      required String label,
      TextInputType inputType = TextInputType.text,
      TextInputAction inputAction = TextInputAction.next,
      required Function(String?) validatorFunction,
      campoDeSenha = false})
      : super(key: key) {
    _label = label;
    _inputType = inputType;
    _inputAction = inputAction;
    _validatorFunction = validatorFunction;
    _campoDeSenha = campoDeSenha;
  }

  @override
  State<CampoEntrada> createState() => CampoEntradaState();
}

class CampoEntradaState extends State<CampoEntrada> {
  late TextEditingController _controller;
  late FocusNode _focus;
  late bool _senhaVisivel;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focus = FocusNode();
    _senhaVisivel = false;
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget._label,
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
        suffixIcon: _getSuffixIcon(_controller, widget._campoDeSenha),
      ),
      focusNode: _focus,
      keyboardType: widget._inputType,
      obscureText: widget._campoDeSenha && !_senhaVisivel,
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
      textInputAction: widget._inputAction,
      onFieldSubmitted: (v) {
        _focus.nextFocus();
      },
      validator: (String? value) {
        return widget._validatorFunction(value);
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

  void requestFocus() {
    _focus.requestFocus();
  }

  String get text {
    return _controller.text;
  }

  set text(String text) {
    _controller.text = text;
  }

  void clear() {
    _controller.clear();
  }
}
