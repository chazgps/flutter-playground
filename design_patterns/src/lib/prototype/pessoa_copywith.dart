import 'package:cli/prototype/pessoa.dart';
import 'package:cli/prototype/pessoas_caracteristicas.dart';

class PessoaCopyWith extends Pessoa {
  PessoaCopyWith(
      {required int idade,
      required Sexo sexo,
      required EstadoCivil estadoCivil})
      : super(idade: idade, sexo: sexo, estadoCivil: estadoCivil);

  // A clonagem se dá pela cópia de todos os atributos, dando a opção de escolha
  // de mudar o valor de algum atributo no processo de clonagem.
  // Este é o padrão adotado no Flutter para clonagem de objetos.
  copyWith({int? idade, Sexo? sexo, EstadoCivil? estadoCivil}) {
    return PessoaCopyWith(
      idade: idade ?? super.idade,
      sexo: sexo ?? super.sexo,
      estadoCivil: estadoCivil ?? super.estadoCivil,
    );
  }
}
