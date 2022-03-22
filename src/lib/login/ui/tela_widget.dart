import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constantes.dart' as constantes;

class Tela extends StatefulWidget {
  late final Widget? _body;

  Tela({Key? key, Widget? body}) : super(key: key) {
    _body = body;
  }

  @override
  _TelaState createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarColor: Colors.black, // navigation bar color
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
            errorStyle: TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_ERRO),
          ),
        ),
        child: GestureDetector(
          onTap: () => Focus.of(context).unfocus(),
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
              // Para desabilitar o efeito Glow ao tentar rolar a tela além do conteúdo existente
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll) {
                  overScroll.disallowIndicator();
                  return false;
                },
                child: CustomScrollView(
                  reverse: true,
                  slivers: [
                    SliverFillRemaining(hasScrollBody: false, child: widget._body!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
