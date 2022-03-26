import 'package:flutter/material.dart';

void inputDialog(BuildContext context,
    {required String titulo,
    required Function(String) onSubmit,
    String initialValue = ''}) async {
  TextEditingController textFieldController = TextEditingController();
  FocusNode focus = FocusNode();

  return showDialog(
      context: context,
      builder: (context) {
        final TextField campo = TextField(
          controller: textFieldController,
          focusNode: focus,
          autofocus: true,
        );
        textFieldController.text = initialValue;

        VoidCallback callbackOK = () {
          Navigator.pop(context);
          onSubmit(textFieldController.text);
        };

        final List<TextButton> botoes = [
          _getBotao('OK', onTap: callbackOK),
          _getBotao('Cancelar', onTap: () => Navigator.pop(context))
        ];

        return _getAlertDialog(titulo, campo, botoes);
      });
}

AlertDialog exibeMensagem(
    BuildContext context, String titulo, String mensagem) {
  return _getAlertDialog(
    titulo,
    Text(mensagem),
    [
      _getBotao('OK', onTap: () {
        Navigator.of(context).pop();
      })
    ],
  );
}

void showSnackBar(BuildContext context, String mensagem) {
  final SnackBar snackBar = SnackBar(
    content: Text(mensagem, style: TextStyle(fontSize: 20)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

AlertDialog _getAlertDialog(
    String titulo, Widget corpo, List<TextButton> botoes) {
  return AlertDialog(
    insetPadding: const EdgeInsets.all(20),
    contentPadding: const EdgeInsets.all(20),
    title: Text(titulo),
    content: corpo,
    actions: botoes,
  );
}

TextButton _getBotao(String titulo, {required VoidCallback onTap}) {
  return TextButton(
    child: Text(titulo),
    onPressed: () {
      onTap();
    },
  );
}
