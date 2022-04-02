import 'package:cli/builder/ingrediente.dart';
import 'package:cli/builder/lanche.dart';

abstract class LancheBuilder {
  late final Lanche _lanche;

  LancheBuilder(String nome) {
    _lanche = Lanche(nome);
  }

  Lanche getLanche() => _lanche;

  LancheBuilder preparaPao() {
    _lanche.adicionarIngrediente(Pao());

    return this;
  }

  LancheBuilder adicionaRecheio() {
    return this;
  }

  LancheBuilder adicionaMolhos() {
    return this;
  }

  Lanche build() => _lanche;
}
