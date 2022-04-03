import 'package:cli/builder/lanche.dart';
import 'package:cli/builder/lanche_builder.dart';

class Montador {
  Lanche montaLanche(LancheBuilder builder) {
    return builder.preparaPao().adicionaRecheio().adicionaMolhos().build();
  }
}
