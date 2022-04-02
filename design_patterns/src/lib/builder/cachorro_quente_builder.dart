import 'package:cli/builder/ingrediente.dart';
import 'package:cli/builder/lanche_builder.dart';

class CachorroQuenteBuilder extends LancheBuilder {
  CachorroQuenteBuilder() : super('Cachorro-Quente');

  @override
  LancheBuilder adicionaRecheio() {
    super.adicionaRecheio();

    getLanche().adicionarIngrediente(Salsicha());
    return this;
  }

  @override
  LancheBuilder adicionaMolhos() {
    super.adicionaMolhos();

    getLanche().adicionarIngrediente(Catchup());
    getLanche().adicionarIngrediente(Mostarda());

    return this;
  }
}
