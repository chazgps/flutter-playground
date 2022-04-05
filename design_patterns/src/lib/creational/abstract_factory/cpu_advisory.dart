import 'package:cli/creational/abstract_factory/vendedor_advisor.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';

abstract class ICPUFactory {
  CPU getCPU(tipoUsuario tipo);
}

class CPUFactory implements ICPUFactory {
  @override
  CPU getCPU(tipoUsuario tipo) {
    switch (tipo) {
      case tipoUsuario.basico:
        return CPUI3();

      case tipoUsuario.dev:
        return CPUI7();

      case tipoUsuario.corporativo:
        return CPUI5();
    }
  }
}
