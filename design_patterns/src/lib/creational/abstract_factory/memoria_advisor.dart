import 'package:cli/creational/abstract_factory/loja_factory.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

abstract class IMemoriaAdvisorFactory {
  IMemoria getMemoria(TipoUsuario tipo);
}

class MemoriaFactory implements IMemoriaAdvisorFactory {
  @override
  IMemoria getMemoria(TipoUsuario tipoUsuario) {
    switch (tipoUsuario) {
      case TipoUsuario.basico:
        return MemoriaDDR1();

      case TipoUsuario.dev:
        return MemoriaDDR4();

      case TipoUsuario.corporativo:
        return MemoriaDDR1();
    }
  }
}