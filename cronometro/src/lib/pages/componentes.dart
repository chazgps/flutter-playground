import 'package:flutter/material.dart';

Widget getBotaoCronometro(bool cronometroLigado, {required VoidCallback onTap}) {
  final String texto =
      cronometroLigado ? 'Parar cronômetro' : 'Iniciar cronômetro';

  return ElevatedButton(
    onPressed: () {
      onTap();
    },
    child: Text(texto),
  );
}
