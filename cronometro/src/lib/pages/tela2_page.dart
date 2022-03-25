import 'package:flutter/material.dart';
import 'package:cronometro/pages/componentes.dart' as ui;
import '../cronometro_regressivo.dart';

class Tela2 extends StatelessWidget {
  late final CronometroRegressivo _cronometro;

  Tela2(CronometroRegressivo cronometro, {Key? key}) : super(key: key) {
    _cronometro = cronometro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 2: AnimatedBuilder')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _cronometro.ligado,
                builder: (BuildContext context, Widget? child) {
                  return ui.getBotaoCronometro(_cronometro.ligado.value, onTap: () {
                    if (_cronometro.ligado.value) {
                      _cronometro.parar();
                    } else {
                      _cronometro.iniciar();
                    }
                  });
                }),
            Center(
              child: AnimatedBuilder(
                animation: _cronometro.valor,
                builder: (BuildContext context, Widget? child) {
                  return Text(_cronometro.valor.value,
                      style: const TextStyle(fontSize: 40));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
