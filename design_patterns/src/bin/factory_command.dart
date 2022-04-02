import 'package:args/command_runner.dart';
import 'package:cli/factory/hash.dart';

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

    IHashGeneratorFactory hashGenerator;

    switch (hash) {
      case 'md5':
        hashGenerator = MD5Factory();
        break;
      case 'sha1':
        hashGenerator = SHA1Factory();
        break;
      default:
        throw Exception('Função de Hash inválida');
    }

    final IHashGenerator generator = hashGenerator.createHashGenerator();
    final String stringEntrada = 'Batatinha frita 1,2,3.';
    print('Conteúdo de entrada = "$stringEntrada"');
    print('Hash calculado com $hash: ' + generator.hash(stringEntrada));
  }
}
