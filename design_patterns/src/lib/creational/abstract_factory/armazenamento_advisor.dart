import 'package:cli/creational/abstract_factory/vendedor_advisor.dart';
import 'package:cli/creational/abstract_factory/armazenamento.dart';

abstract class IArmazenamentoFactory {
  Armazenamento getArmazenamento(tipoUsuario tipo);
}

class ArmazenamentoFactory implements IArmazenamentoFactory {
  @override
  Armazenamento getArmazenamento(tipoUsuario tipo) {
    switch (tipo) {
      case tipoUsuario.basico:
        return ArmazenamentoHDD();

      case tipoUsuario.dev:
        return ArmazenamentoSSD();

      case tipoUsuario.corporativo:
        return ArmazenamentoHDD();
    }
  }
}
