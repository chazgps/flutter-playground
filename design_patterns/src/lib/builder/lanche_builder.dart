import 'package:cli/builder/ingrediente.dart';
import 'package:cli/builder/lanche.dart';

abstract class LancheBuilder {
  late final Lanche _lanche;

  LancheBuilder(String nome) {
    _lanche = Lanche(nome);
  }

  /// Fornece ao Builder acesso ao lanche.
  /// O Dart não tem membros protected como o Java e outras linguagens
  /// então vamos ter fornecer ao Builder acesso ao lanche através de um método comum.
  Lanche getLanche() => _lanche;

  /// Fornece ao Builder uma implementação padrão para o método
  /// pois todo lanche envolve incluir o pão como ingrediente.
  LancheBuilder preparaPao() {
    _lanche.adicionarIngrediente(Pao());

    return this;
  }

  /// Implementação básica permitindo que o Builder não precise
  /// implementar este método se ele não for relevante para ele.
  LancheBuilder adicionaRecheio() {
    return this;
  }

  /// Implementação básica permitindo que o Builder não precise
  /// implementar este método se ele não for relevante para ele.
  LancheBuilder adicionaMolhos() {
    return this;
  }

  Lanche build() => _lanche;
}
