import 'dart:async';

import 'package:flutter/foundation.dart';

class CronometroRegressivo {
  late int _minutos;
  late Timer _timer;
  late ValueNotifier<bool> ligado;
  late int _contadorSegundos;
  late ValueNotifier<String> valor;

  CronometroRegressivo({required minutos}) {
    _minutos = minutos;

    _rearmaContagem();

    ligado =ValueNotifier(false);
    valor = ValueNotifier(_getTempoFormatado());
  }

  void _rearmaContagem(){
    _contadorSegundos = _minutos * 60;
  }

  void iniciar() {
    _rearmaContagem();

    if (ligado.value) {
      parar();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), contaTempo);
    ligado.value = true;
  }

  void contaTempo(Timer timer) {
    _contadorSegundos--;
    valor.value = _getTempoFormatado();

    debugPrint('Tempo restante: {$_contadorSegundos}');

    if (_contadorSegundos == 0) {
      debugPrint('Timer parado.');
      parar();
    }
  }

  void parar() {
    if (ligado.value) {
      _timer.cancel();
      ligado.value = false;
    }
  }

  String _getTempoFormatado() {
    String minutos =
        (_contadorSegundos ~/ 60).toString().padLeft(2, '0');
    String segundos = (_contadorSegundos % 60).toString().padLeft(2, '0');

    String valorParaExibir = minutos + ':' + segundos;

    return valorParaExibir;
  }
}
