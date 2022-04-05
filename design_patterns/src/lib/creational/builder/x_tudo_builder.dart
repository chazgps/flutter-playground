import 'package:cli/creational/builder/ingrediente.dart';
import 'package:cli/creational/builder/lanche_builder.dart';

class XTudoBuilder extends LancheBuilder {
  XTudoBuilder() : super('X-Tudo');

    @override
  LancheBuilder adicionaRecheio() {

    getLanche().adicionarIngrediente(Carne());
    getLanche().adicionarIngrediente(Tomate());
    getLanche().adicionarIngrediente(Alface());
    getLanche().adicionarIngrediente(Ovo());
    getLanche().adicionarIngrediente(Queijo());
    return this;
  }
}
