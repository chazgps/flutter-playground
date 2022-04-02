import 'package:args/command_runner.dart';
import 'package:cli/singleton/app_settings.dart';

class SingletonCommand extends Command {
  @override
  String get name => 'singleton';

  @override
  String get description => 'Teste do padrão Singleton';

  SingletonCommand() {
    argParser.addOption('singleton');
  }

  @override
  void run() {
    final AppSettings app1 = AppSettings();
    final AppSettings app2 = AppSettings();

    final String titulo = "Design Pattern: Singleton";

    print(titulo);
    print(''.padRight(titulo.length, '=') + '\n');

    print(
        'Os objetos app1 e app2 são iguais ? ${app1 == app2 ? 'SIM' : 'NÃO'}');
  }
}
