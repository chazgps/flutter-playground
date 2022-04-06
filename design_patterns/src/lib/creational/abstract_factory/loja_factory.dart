// ignore_for_file: constant_identifier_names

import 'package:cli/creational/abstract_factory/armazenamento.dart';
import 'package:cli/creational/abstract_factory/computador.dart';
import 'package:cli/creational/abstract_factory/computador_advisor.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';
import 'package:cli/creational/abstract_factory/fabricante.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

enum TipoUsuario {
  basico,
  dev,
  corporativo,
}

enum FabricantesVendidos { Dell }

abstract class ILojaFactory {
  String get getNome;
  IComputador getConfiguracaoRecomendada(
      FabricantesVendidos fabricante, TipoUsuario tipoUsuario);
}

class MagazineLuizaFactory implements ILojaFactory {

  @override
  String get getNome =>'Magazine Luiza';

  @override
  IComputador getConfiguracaoRecomendada(
      FabricantesVendidos fabricante, TipoUsuario tipoUsuario) {
    IFabricanteFactory fabricanteFactory;

    switch (fabricante) {
      case FabricantesVendidos.Dell:
        fabricanteFactory = DellFactory();
        break;
      default:
        throw Exception('Fabricante não suportado');
    }

    final IMemoria memoriaEscolhida =
        fabricanteFactory.getMemoriaAdvisor().getMemoria(tipoUsuario);
    final IArmazenamento armazenamentoEscolhido =
        fabricanteFactory.getArmazenamentoAdvisor().getArmazenamento(tipoUsuario);
    final ICPU cpuEscolhida = fabricanteFactory.getCPUAdvisor().getCPU(tipoUsuario);

    final ComputadorAdvisor advisor = ComputadorAdvisor();
    final IComputador computadorEscolhido = advisor
        .comCPU(cpuEscolhida)
        .comMemoria(memoriaEscolhida)
        .comArmazenamento(armazenamentoEscolhido)
        .construir(tipoUsuario);

    return computadorEscolhido;
  }
}
