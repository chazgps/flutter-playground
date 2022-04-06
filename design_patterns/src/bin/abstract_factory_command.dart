import 'package:args/command_runner.dart';
import 'package:cli/creational/abstract_factory/loja_factory.dart';
import 'package:cli/creational/abstract_factory/computador.dart';

class AbstractFactoryCommand extends Command {
  @override
  String get name => 'abstract_factory';

  @override
  String get description => 'Teste do padrão Abstract Factory';

  @override
  void run() {
    final String titulo = "Design Pattern: Abstract Factory";

    print(titulo);
    print(''.padRight(titulo.length, '=') + '\n');

    ILojaFactory loja = MagazineLuizaFactory();
    print('\nRecomendações da loja ${loja.getNome} por perfil de usuário\n');

    _exibeRecomendacaoPara(loja, TipoUsuario.basico);
    _exibeRecomendacaoPara(loja, TipoUsuario.dev);
    _exibeRecomendacaoPara(loja, TipoUsuario.corporativo);
  }

  void _exibeRecomendacaoPara(ILojaFactory loja, TipoUsuario tipoUsuario) {
    final IComputador computador =
        loja.getConfiguracaoRecomendada(FabricantesVendidos.Dell, tipoUsuario);

    print(
        '\nConfiguração para um usuário ${tipoUsuario.name}:\n');
    print('Fabricante:\t${FabricantesVendidos.Dell.name}');

    print('CPU:\t\t${computador.cpu.nome}, ${computador.cpu.nucleos}');
    print(
        'Memória\t\t${computador.memoria.tipo}, ${computador.memoria.capacidade}');
    print(
        'Armazenamento\t${computador.armazenamento.tipo}, ${computador.armazenamento.velocidade}');
  }
}
