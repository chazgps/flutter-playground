import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constantes.dart' as constantes;

class Tela extends StatefulWidget {
  late final dynamic _titulo;
  late final Widget? _body;
  late final List<Widget>? _actions;
  late final Widget? _floatingActionButton;
  late final bool _lockOrientationInPortrait;
  late final VoidCallback? _onExitCallback;

  Tela(
      {Key? key,
      dynamic titulo,
      Widget? body,
      List<Widget>? actions,
      Widget? floatingActionButton,
      bool lockOrientationInPortrait = false,
      VoidCallback? onExit})
      : super(key: key) {
    _titulo = titulo;
    _body = body;
    _actions = actions;
    _floatingActionButton = floatingActionButton;
    _lockOrientationInPortrait = lockOrientationInPortrait;
    _onExitCallback = onExit;
  }

  @override
  _TelaState createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  @override
  void initState() {
    super.initState();

    if (widget._lockOrientationInPortrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarColor: Colors.black, // navigation bar color
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget titulo;
    AppBar? _appBar;

    if (widget._titulo != null) {
      if (widget._titulo is String) {
        titulo = Text(widget._titulo);
      } else {
        titulo = widget._titulo;
      }

      _appBar = AppBar(
        actions: widget._actions,
        title: Semantics(hint: 'titulo da tela', child: titulo),
        elevation: 0,
      );
    }

    return WillPopScope(
      onWillPop: () async {
        widget._onExitCallback?.call();

        return true;
      },
      child: Scaffold(
        appBar: _appBar,
        body: SafeArea(
          child: Theme(
            data: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
                errorStyle: TextStyle(fontSize: constantes.TAMANHO_FONTE_MENOR, color: constantes.COR_TEXTO_ERRO),
              ),
            ),
            child: SingleChildScrollView(
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
                    child: widget._body!,
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: widget._floatingActionButton,
      ),
    );
  }
}
