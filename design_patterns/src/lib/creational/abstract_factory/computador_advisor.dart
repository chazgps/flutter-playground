import 'package:cli/creational/abstract_factory/loja_factory.dart';
import 'package:cli/creational/abstract_factory/armazenamento.dart';
import 'package:cli/creational/abstract_factory/computador.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

abstract class IComputadorFactory {
  ComputadorAdvisor comMemoria(IMemoria memoria);
  ComputadorAdvisor comCPU(ICPU cpu);
  ComputadorAdvisor comArmazenamento(IArmazenamento armazenamento);
  IComputador construir(TipoUsuario tipo);
}

enum tipoComputador { desktop, notebook }

class ComputadorAdvisor implements IComputadorFactory {
  late IMemoria _memoriaEscolhida;
  late ICPU _cpuEscolhida;
  late IArmazenamento _armazenamentoEscolhido;

  /// Aqui é onde ocorre a escolha do tipo de computador conforme o tipo de usuário
  /// Esta implementação é simples, mas poderia ter lógicas mais complexas levando
  /// em consideração os tipos de cada componente escolhido (cpu, memória e armazenamento)
  @override
  IComputador construir(TipoUsuario tipoUsuario) {
    final IComputador computadorEscolhido;

    switch (tipoUsuario) {
      case TipoUsuario.basico:
        computadorEscolhido =
            NoteBook(_cpuEscolhida, _memoriaEscolhida, _armazenamentoEscolhido);
        break;

      case TipoUsuario.dev:
        computadorEscolhido =
            NoteBook(_cpuEscolhida, _memoriaEscolhida, _armazenamentoEscolhido);
        break;

      case TipoUsuario.corporativo:
        computadorEscolhido =
            Desktop(_cpuEscolhida, _memoriaEscolhida, _armazenamentoEscolhido);
        break;
    }

    return computadorEscolhido;
  }

  @override
  ComputadorAdvisor comArmazenamento(IArmazenamento armazenamento) {
    _armazenamentoEscolhido = armazenamento;
    return this;
  }

  @override
  ComputadorAdvisor comCPU(ICPU cpu) {
    _cpuEscolhida = cpu;
    return this;
  }

  @override
  ComputadorAdvisor comMemoria(IMemoria memoria) {
    _memoriaEscolhida = memoria;
    return this;
  }
}
