import 'package:flutter/material.dart';
import 'package:tema_escuro/configuracoes.dart';
import 'package:tema_escuro/principal_page.dart';
import 'package:tema_escuro/tema.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Configuracoes.tema,
      builder: (context, tema, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Tema.getTemaClaro(),
          darkTheme: Tema.getTemaEscuro(),
          themeMode: Configuracoes.tema.value,
          home: const PrincipalPage(),
        );
      },
    );
  }
}
