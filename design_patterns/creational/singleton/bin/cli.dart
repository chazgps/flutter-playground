import 'package:cli/app_settings.dart';

void main(List<String> arguments) {
  final AppSettings app1 = AppSettings();
  final AppSettings app2 = AppSettings();

  final String titulo = "Design Pattern: Singleton";

  print(titulo);
  print(''.padRight(titulo.length, '=') + '\n');

  print('Os objetos app1 e app2 são iguais ? ${app1 == app2 ? 'SIM' : 'NÃO'}');
}
