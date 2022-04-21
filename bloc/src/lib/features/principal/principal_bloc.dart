import 'dart:async';

import '../bloc.dart';
import 'principal_states.dart';
import 'principal_events.dart';

class PrincipalBloc implements Bloc {
  late int _contador;
  late final StreamController<PrincipalEvent> _eventosController;
  late final StreamController<PrincipalState> _estadosController;
  late final Stream<PrincipalState> _streamEstados;

  PrincipalBloc() {
    _eventosController = StreamController<PrincipalEvent>();
    _eventosController.stream.listen(_mapEventToState);

    _estadosController = StreamController<PrincipalState>();
    _streamEstados = _estadosController.stream.asBroadcastStream();
  }

  Sink<PrincipalEvent> get entrada => _eventosController.sink;

  Stream<PrincipalState> get saida => _streamEstados;

  @override
  void dispose() {
    _eventosController.close();
    _estadosController.close();
  }

  void _mapEventToState(PrincipalEvent evento) {
    PrincipalState estado;

    if (evento is LoadingEvent) {
      estado = _getEstadoFromLoadingEvent(evento);
    } else if (evento is IncrementoEvent) {
      estado = _getEstadoFromIncrementoEvent(evento);
    } else if (evento is DecrementoEvent) {
      estado = _getEstadoFromDecrementoEvent(evento);
    } else {
      estado = InvalidState();
    }

    _estadosController.add(estado);
  }

  PrincipalState _getEstadoFromLoadingEvent(PrincipalEvent evento) {
    _contador = 0;
    return InitialState(valor: _contador);
  }

  PrincipalState _getEstadoFromIncrementoEvent(PrincipalEvent evento) {
    _contador++;
    return ContadorAtualizadoState(valor: _contador);
  }

  PrincipalState _getEstadoFromDecrementoEvent(PrincipalEvent evento) {
    _contador--;
    return ContadorAtualizadoState(valor: _contador);
  }
}
