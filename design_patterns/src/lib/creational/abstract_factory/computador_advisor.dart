import 'package:cli/creational/abstract_factory/vendedor_advisor.dart';
import 'package:cli/creational/abstract_factory/armazenamento.dart';
import 'package:cli/creational/abstract_factory/computador.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

abstract class IComputadorFactory {
  ComputadorAdvisor recomendePara(tipoUsuario tipo);
  ComputadorAdvisor comMemoria(Memoria memoria);
  ComputadorAdvisor comCPU(CPU cpu);
  ComputadorAdvisor comArmazenamento(Armazenamento armazenamento);
  Computador construir();
}

enum tipoComputador { desktop, notebook }

class ComputadorAdvisor implements IComputadorFactory {
  late tipoComputador _computadorEscolhido;
  late Memoria _memoriaEscolhida;
  late CPU _cpuEscolhida;
  late Armazenamento _armazenamentoEscolhido;

  @override
  ComputadorAdvisor recomendePara(tipoUsuario tipo) {
    switch (tipo) {
      case tipoUsuario.basico:
        _computadorEscolhido = tipoComputador.notebook;
        return this;

      case tipoUsuario.dev:
        _computadorEscolhido = tipoComputador.notebook;
        return this;

      case tipoUsuario.corporativo:
        _computadorEscolhido = tipoComputador.desktop;
        return this;
    }
  }

  @override
  Computador construir() {
    final Computador computadorEscolhido;

    switch (_computadorEscolhido) {
      case tipoComputador.desktop:
        computadorEscolhido =
            Desktop(_cpuEscolhida, _memoriaEscolhida, _armazenamentoEscolhido);
        break;

      case tipoComputador.notebook:
        computadorEscolhido =
            NoteBook(_cpuEscolhida, _memoriaEscolhida, _armazenamentoEscolhido);
        break;
    }

    return computadorEscolhido;
  }

  @override
  ComputadorAdvisor comArmazenamento(Armazenamento armazenamento) {
    _armazenamentoEscolhido = armazenamento;
    return this;
  }

  @override
  ComputadorAdvisor comCPU(CPU cpu) {
    _cpuEscolhida = cpu;
    return this;
  }

  @override
  ComputadorAdvisor comMemoria(Memoria memoria) {
    _memoriaEscolhida = memoria;
    return this;
  }
}
