import 'package:flutter/material.dart';

import 'campo_entrada.dart';

Widget getLogo() {
  return const SizedBox(
    height: 100,
    width: 200,
    child: Placeholder(
      color: Colors.red,
    ),
  );
}

CampoEntrada getCampoNome(GlobalKey<CampoEntradaState> key) {
  return CampoEntrada(
    key: key,
    label: 'Seu nome',
    //inputType: TextInputType.name,
    validatorFunction: (String? valor) {
      if (valor == null || valor.isEmpty) {
        key.currentState!.requestFocus();
        return 'A nome não pode ser vazia !';
      } else {
        return null;
      }
    },
  );
}

CampoEntrada getCampoEmail(GlobalKey<CampoEntradaState> key) {
  return CampoEntrada(
    key: key,
    label: 'Email',
    //inputType: TextInputType.text,
    validatorFunction: (String? valor) {
      if (valor == null || valor.isEmpty) {
        key.currentState!.requestFocus();
        return 'A e-mail não pode ser vazia !';
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
