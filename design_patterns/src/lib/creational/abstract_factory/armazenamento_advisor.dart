import 'package:cli/creational/abstract_factory/loja_factory.dart';
import 'package:cli/creational/abstract_factory/armazenamento.dart';

abstract class IArmazenamentoFactory {
  IArmazenamento getArmazenamento(TipoUsuario tipo);
}

class ArmazenamentoFactory implements IArmazenamentoFactory {
  @override
  IArmazenamento getArmazenamento(TipoUsuario tipoUsuario) {
    switch (tipoUsuario) {
      case TipoUsuario.basico:
        return ArmazenamentoHDD();

      case TipoUsuario.dev:
        return ArmazenamentoSSD();

      case TipoUsuario.corporativo:
        return ArmazenamentoHDD();
    }
  }
}
