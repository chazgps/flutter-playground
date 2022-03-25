import 'package:cronometro/cronometro_regressivo.dart';
import 'package:cronometro/pages/componentes.dart' as ui;
import 'package:flutter/material.dart';

import 'tela2_page.dart';

class Tela1 extends StatelessWidget {
  late final CronometroRegressivo _cronometro;

  Tela1(CronometroRegressivo cronometro, {Key? key}) : super(key: key) {
    _cronometro = cronometro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela 1: ValueListenableBuilder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: _cronometro.ligado,
                builder: (BuildContext context, bool valor, Widget? child) {
                  return ui.getBotaoCronometro(valor, onTap: () {
                    if (_cronometro.ligado.value) {
                      _cronometro.parar();
                    } else {
                      _cronometro.iniciar();
                    }
                  });
                }),
            ValueListenableBuilder(
              valueListenable: _cronometro.valor,
              builder: (BuildContext context, String valor, Widget? child) {
                return Text(valor, style: const TextStyle(fontSize: 40));
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Tela2(_cronometro)),
                );
              },
              child: const Text('Nova tela'),
            ),
          ],
        ),
      ),
    );
  }
}
