import 'package:args/command_runner.dart';
import 'package:cli/creational/abstract_factory/vendedor_advisor.dart';
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

    IVendedorFactory vendedorFactory = VendedorFactory();
    _exibeRecomendacaoPara(vendedorFactory, tipoUsuario.basico);
    _exibeRecomendacaoPara(vendedorFactory, tipoUsuario.dev);
    _exibeRecomendacaoPara(vendedorFactory, tipoUsuario.corporativo);
  }

  void _exibeRecomendacaoPara(
      IVendedorFactory vendedor, tipoUsuario tipoUsuario) {
    final Computador computador =
        vendedor.getConfiguracaoRecomendada(tipoUsuario);

    print('\nRecomendação de computador para um usuário ${tipoUsuario.name}');
    print('CPU:\t\t${computador.cpu.nome}, ${computador.cpu.nucleos}');
    print(
        'Memória\t\t${computador.memoria.tipo}, ${computador.memoria.capacidade}');
    print(
        'Armazenamento\t${computador.armazenamento.tipo}, ${computador.armazenamento.velocidade}');
  }
}
