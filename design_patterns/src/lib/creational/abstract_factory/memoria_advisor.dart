import 'package:cli/creational/abstract_factory/vendedor_advisor.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

abstract class IMemoriaFactory {
  Memoria getMemoria(tipoUsuario tipo);
}

class MemoriaFactory implements IMemoriaFactory {
  @override
  Memoria getMemoria(tipoUsuario tipo) {
    switch (tipo) {
      case tipoUsuario.basico:
        return MemoriaDDR1();

      case tipoUsuario.dev:
        return MemoriaDDR4();

      case tipoUsuario.corporativo:
        return MemoriaDDR1();
    }
  }
}