abstract class PrincipalState {}

class InvalidState extends PrincipalState {}

class InitialState extends PrincipalState {
  late final int valor;

  InitialState({required this.valor});
}

class ContadorAtualizadoState extends PrincipalState {
  late final int valor;

  ContadorAtualizadoState({required this.valor});
}
