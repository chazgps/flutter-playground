import 'package:flutter/material.dart';

import '../constantes.dart' as constantes;
import 'campo_entrada.dart';

Widget getPainel(BuildContext context, String texto) {
  return Padding(
    padding: const EdgeInsets.only(bottom: constantes.ESPACO_BORDA),
    child: Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40.0), bottomLeft: Radius.circular(40.0)),
      ),
      width: double.infinity,
      height: 150,
      alignment: Alignment.bottomCenter,
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: constantes.TAMANHO_FONTE_ORIENTACAO_TITULO),
      ),
    ),
  );
}

Widget getCampoNome(GlobalKey<CampoEntradaState> key) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: CampoEntrada(
      key: key,
      label: 'Seu nome',
      //inputType: TextInputType.name,
      validatorFunction: (String? valor) {
        if (valor == null || valor.isEmpty) {
          key.currentState!.requestFocus();
          return 'A nome não pode ser vazio !';
        } else {
          return null;
        }
      },
    ),
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
        return 'A e-mail não pode ser vazio !';
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
  return Padding(
    padding: const EdgeInsets.only(top: 30),
    child: SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(texto, style: const TextStyle(fontSize: 18)),
      ),
    ),
  );
}

Future<void> exibeMensagem(BuildContext context, String titulo, String mensagem) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      title: Text(titulo),
      content: Text(mensagem),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
