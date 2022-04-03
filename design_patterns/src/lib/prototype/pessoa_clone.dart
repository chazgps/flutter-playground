import 'package:cli/prototype/pessoa.dart';
import 'package:cli/prototype/pessoas_caracteristicas.dart';

class PessoaClone extends Pessoa {
  PessoaClone(
      {required int idade,
      required Sexo sexo,
      required EstadoCivil estadoCivil})
      : super(idade: idade, sexo: sexo, estadoCivil: estadoCivil);

  // A clonagem se dá pela cópia de todos os atributos, ou seja, o clone
  // é uma cópia identica do estado do objeto clonado.
  PessoaClone clone() {
    return PessoaClone(
      idade: super.idade,
      sexo: super.sexo,
      estadoCivil: super.estadoCivil,
    );
  }
}
