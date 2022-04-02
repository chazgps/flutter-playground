import 'package:args/command_runner.dart';
import 'package:cli/builder/cachorro_quente_builder.dart';
import 'package:cli/builder/lanche.dart';
import 'package:cli/builder/lanche_builder.dart';
import 'package:cli/builder/montador.dart';
import 'package:cli/builder/x_tudo_builder.dart';

class BuilderCommand extends Command {
  @override
  String get name => 'builder';

  @override
  String get description => 'Teste do padrão Builder';

  BuilderCommand() {
    argParser.addOption('lanche',
        mandatory: true, allowed: ['x-tudo', 'hotdog'], help: 'Tipo do lanche');
  }

  @override
  void run() {
    final String nomeLanche = argResults!['lanche'];

    final LancheBuilder receita;

    switch (nomeLanche) {
      case 'hotdog':
        receita = CachorroQuenteBuilder();
        break;
      case 'x-tudo':
        receita = XTudoBuilder();
        break;
      default:
        throw Exception('Lanche selecionado inválido');
    }

    final Montador montador = Montador();
    final Lanche lanche = montador.montaLanche(receita);

    final String titulo = "Design Pattern: Builder";

    print(titulo);
    print(''.padRight(titulo.length, '=') + '\n');

    print('Lanche pedido: ${lanche.nome}');
    print('Ingredientes: ${lanche.ingredientes}');
    print('Preço: ${lanche.preco}');
  }
}
