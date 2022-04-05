import 'package:cli/creational/prototype/pessoas_caracteristicas.dart';

class Pessoa {
  late int idade;
  late Sexo sexo;
  late EstadoCivil estadoCivil;

  Pessoa({required this.idade, required this.sexo, required this.estadoCivil});
}
