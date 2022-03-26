import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onpause/life_cycle_monitor_mixin.dart';
import 'package:onpause/log.dart';

class PrincipalPage extends StatelessWidget with LifeCycleMonitor {
  final Log _log = Log();

  PrincipalPage() {
    initLifeCycleMonitor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ciclo de vida do app'),
      ),
      body: AnimatedBuilder(
        animation: _log,
        builder: (context, child) {
          return ListView.builder(
            itemCount: _log.eventos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_log.eventos[index]),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void onResume() {
    print('App resumida.');
    _log.add('App resumida às ' + _getDataHora());
  }

  @override
  void onPause() {
    print('App pausada.');
    _log.add('App pausada às ' + _getDataHora());
  }

  String _getDataHora() {
    final DateTime data = DateTime.now();
    final DateFormat formatador = DateFormat("HH:mm:ss 'de' dd/MM/yyyy");
    return formatador.format(data);
  }
}
