import 'package:args/command_runner.dart';
import 'package:cli/factory/hash_generator_abstract.dart';
import 'package:cli/factory/hash_factory.dart';

class FactoryCommand extends Command {
  @override
  String get name => 'factory';

  @override
  String get description => 'Teste do padrão Factory';

  FactoryCommand() {
    argParser.addOption('hash',
        mandatory: true, allowed: ['md5', 'sha1'], help: 'Função de Hash');
  }

  @override
  void run() {
    final String hash = argResults!['hash'];

    IHashGenerator geradorHash;

    switch (hash) {
      case 'md5':
        geradorHash = HashFactory().getHashGenerator(hashType.md5);
        break;
      case 'sha1':
        geradorHash = HashFactory().getHashGenerator(hashType.sha1);
        break;
      default:
        throw Exception('Função de Hash inválida');
    }

    final String stringEntrada = 'Batatinha frita 1,2,3.';
    print('Conteúdo de entrada = "$stringEntrada"');
    print('Hash calculado com $hash: ' + geradorHash.hash(stringEntrada));
  }
}
