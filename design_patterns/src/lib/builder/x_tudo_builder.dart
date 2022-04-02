import 'package:cli/builder/ingrediente.dart';
import 'package:cli/builder/lanche.dart';
import 'package:cli/builder/lanche_builder.dart';

class XTudoBuilder extends LancheBuilder {
  XTudoBuilder() : super('X-Tudo');

    @override
  LancheBuilder adicionaRecheio() {
    super.adicionaRecheio();

    getLanche().adicionarIngrediente(Carne());
    getLanche().adicionarIngrediente(Tomate());
    getLanche().adicionarIngrediente(Alface());
    getLanche().adicionarIngrediente(Ovo());
    getLanche().adicionarIngrediente(Queijo());
    return this;
  }
}
