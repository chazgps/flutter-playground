import 'package:bloc/bloc.dart';
import 'package:teste_block/features/principal_event.dart';
import 'package:teste_block/features/principal_state.dart';

class BlocComPlugin extends Bloc<PrincipalEvent, PrincipalState> {
  late int _contador;

  BlocComPlugin() : super(InitialState(valor: 0)) {
    on<LoadingEvent>((event, emit) => emit(_getEstadoFromLoadingEvent(event)));
    on<IncrementoEvent>((event, emit) => emit(_getEstadoFromIncrementoEvent(event)));
    on<DecrementoEvent>((event, emit) => emit(_getEstadoFromDecrementoEvent(event)));
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
