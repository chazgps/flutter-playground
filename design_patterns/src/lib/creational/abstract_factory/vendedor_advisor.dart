import 'package:cli/creational/abstract_factory/armazenamento.dart';
import 'package:cli/creational/abstract_factory/armazenamento_advisor.dart';
import 'package:cli/creational/abstract_factory/computador.dart';
import 'package:cli/creational/abstract_factory/computador_advisor.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';
import 'package:cli/creational/abstract_factory/cpu_advisory.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';
import 'package:cli/creational/abstract_factory/memoria_advisor.dart';

enum tipoUsuario {
  basico,
  dev,
  corporativo,
}

abstract class IVendedorFactory {
  Computador getConfiguracaoRecomendada(tipoUsuario tipo);
}

class VendedorFactory implements IVendedorFactory {
  @override
  Computador getConfiguracaoRecomendada(tipoUsuario tipo) {
    final Memoria memoriaEscolhido = MemoriaFactory().getMemoria(tipo);
    final Armazenamento armazenamentoEscolhido =
        ArmazenamentoFactory().getArmazenamento(tipo);
    final CPU cpuEscolhido = CPUFactory().getCPU(tipo);

    final ComputadorAdvisor advisor = ComputadorAdvisor();
    final Computador computadorEscolhido = advisor
        .recomendePara(tipo)
        .comCPU(cpuEscolhido)
        .comMemoria(memoriaEscolhido)
        .comArmazenamento(armazenamentoEscolhido)
        .construir();

    return computadorEscolhido;
  }
}
