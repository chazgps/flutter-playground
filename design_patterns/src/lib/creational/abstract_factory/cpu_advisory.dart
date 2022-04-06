import 'package:cli/creational/abstract_factory/loja_factory.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';

abstract class ICPUFactory {
  ICPU getCPU(TipoUsuario tipo);
}

class CPUFactory implements ICPUFactory {
  @override
  ICPU getCPU(TipoUsuario tipoUsuario) {
    switch (tipoUsuario) {
      case TipoUsuario.basico:
        return CPUI3();

      case TipoUsuario.dev:
        return CPUI7();

      case TipoUsuario.corporativo:
        return CPUI5();
    }
  }
}
