import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final MethodChannel platform = const MethodChannel('acme.open_app/intent');
  String _mensagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abrindo outro App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Abrir Calculadora'),
              onPressed: () {
                _abrirCalculadora();
              },
            ),
            Text(_mensagem,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  void _abrirCalculadora() {
    // ignore: unused_local_variable
    const String pacoteMotorola = 'com.android.calculator';
    // ignore: unused_local_variable
    const String pacoteSamsung = 'com.sec.android.app.popupcalculator';

    _abrirApp(pacoteSamsung);
  }

  void _abrirApp(String pacote) async {
    try {
      final Map<String, String> parametros = {'pacote': pacote};
      await platform.invokeMethod('openApp', parametros);

      _mensagem = 'Aplicativo aberto com sucesso!';
    } on PlatformException catch (e) {
      _mensagem = "Erro durante a tentativa de abrir o app: '${e.code}'.";
    }

    setState(() {});
  }
}
