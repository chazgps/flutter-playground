import 'package:flutter/material.dart';

import 'ui/campo_entrada.dart';

Widget getLogo() {
  return const SizedBox(
    height: 100,
    width: 200,
    child: Placeholder(
      color: Colors.red,
    ),
  );
}

CampoEntrada getCampoEmail(GlobalKey<CampoEntradaState> key) {
  return CampoEntrada(
    key: key,
    label: 'Login',
    validatorFunction: (valor) {
      if (valor == null || valor.isEmpty) {
        key.currentState!.requestFocus();
        return 'O login não pode ser vazio !';
      } else {
        return null;
      }
    },
  );
}

CampoEntrada getCampoSenha(GlobalKey<CampoEntradaState> key) {
  return CampoEntrada(
    key: key,
    label: 'Senha',
    inputAction: TextInputAction.done,
    validatorFunction: (String? valor) {
      if (valor == null || valor.isEmpty) {
        key.currentState!.requestFocus();
        return 'A senha não pode ser vazia !';
      } else {
        return null;
      }
    },
    campoDeSenha: true,
  );
}

Widget getBotao(String texto, {required VoidCallback onTap}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: const Text('Entrar'),
    ),
  );
}
