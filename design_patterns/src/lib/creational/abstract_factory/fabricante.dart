
import 'package:cli/creational/abstract_factory/armazenamento_advisor.dart';
import 'package:cli/creational/abstract_factory/cpu_advisory.dart';
import 'package:cli/creational/abstract_factory/memoria_advisor.dart';

abstract class IFabricanteFactory {
  IMemoriaAdvisorFactory getMemoriaAdvisor();
  IArmazenamentoFactory getArmazenamentoAdvisor();
  ICPUFactory getCPUAdvisor();
}

class DellFactory implements IFabricanteFactory {
  @override
  IMemoriaAdvisorFactory getMemoriaAdvisor() {
    return MemoriaFactory();
  }

  @override
  IArmazenamentoFactory getArmazenamentoAdvisor() {
    return ArmazenamentoFactory();
  }

  @override
  ICPUFactory getCPUAdvisor() {
    return CPUFactory();
  }
}
