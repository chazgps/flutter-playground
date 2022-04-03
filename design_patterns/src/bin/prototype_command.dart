import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:cli/prototype/pessoa.dart';
import 'package:cli/prototype/pessoa_copywith.dart';
import 'package:cli/prototype/pessoa_clone.dart';
import 'package:cli/prototype/pessoas_caracteristicas.dart';

class PrototypeCommand extends Command {
  @override
  String get name => 'prototype';

  @override
  String get description => 'Teste do padrão Prototype';

  PrototypeCommand() {
    argParser.addOption('metodo',
        mandatory: true,
        allowed: ['copyWith', 'clone'],
        help: 'Método ao usar para clonar objetos');
  }

  @override
  void run() {
    final String metodo = argResults!['metodo'];

    List<Pessoa> populacao = geraPopulacaoViaClonagem(metodo);

    final String titulo = "Design Pattern: Prototype";

    print(titulo);
    print(''.padRight(titulo.length, '=') + '\n');

    print('A clonagem do objeto Adão se dará pelo método $metodo()\n');
    
    final int qtdeClones = populacao.length - 1;
    print('Qtde de pessoas clonadas a partir de 1 indivíduo: $qtdeClones');

    Map<String, int> qtdePessoas =
        getTotal(populacao, (p) => p.sexo == Sexo.masculino);
    populacao.where((p) => p.sexo == Sexo.masculino).length;
    print(
        'Qtde de homens: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas = getTotal(populacao, (p) => p.sexo == Sexo.feminino);
    print(
        'Qtde de mulheres: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas = getTotal(populacao, (p) => p.idade < 30);
    print(
        'Qtde de jovens: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas = getTotal(populacao, (p) => p.idade >= 30 && p.idade < 60);
    print(
        'Qtde de adultos: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas = getTotal(populacao, (p) => p.idade >= 60);
    print(
        'Qtde de idosos: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    print('');
    qtdePessoas =
        getTotal(populacao, (p) => p.estadoCivil == EstadoCivil.solteira);
    print(
        'Qtde de solteiras: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas =
        getTotal(populacao, (p) => p.estadoCivil == EstadoCivil.casada);
    print(
        'Qtde de casadas: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas =
        getTotal(populacao, (p) => p.estadoCivil == EstadoCivil.separada);
    print(
        'Qtde de separadas: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');

    qtdePessoas =
        getTotal(populacao, (p) => p.estadoCivil == EstadoCivil.viuva);
    print(
        'Qtde de viuvas: ${qtdePessoas['total']} (${qtdePessoas['percentual']}%)');
  }
}

List<Pessoa> geraPopulacaoViaClonagem(String metodoClonagem) {
  // ignore: prefer_typing_uninitialized_variables
  var adao;

  // Define o objeto pai e como será feita a clonagem
  if (metodoClonagem=='copyWith'){
    adao=PessoaCopyWith(idade: 25, sexo: Sexo.masculino, estadoCivil: EstadoCivil.solteira);
  } else {
    adao=PessoaClone(idade: 25, sexo: Sexo.masculino, estadoCivil: EstadoCivil.solteira);
  }

  var pessoas = [];

  // Adiciona Adão como primeiro indivíduo da população
  pessoas.add(adao);

  for (int i = 0; i < 999; i++) {
    Sexo? sexoIndividuo;
    EstadoCivil? estadoCivilIndividuo;
    int? idadeIndividuo;

    // Qual caracterísitca deve ser alterada quando clonar?
    final int caracteristica = Random().nextInt(3);

    switch (caracteristica) {
      case 0:
        sexoIndividuo = getSexoAleatorio();
        break;
      case 1:
        estadoCivilIndividuo = getEstadoCivilAleatorio();
        break;
      case 2:
        idadeIndividuo = getIdadeAleatoria();
    }

    // ignore: prefer_typing_uninitialized_variables
    var pessoaClone;
    if (metodoClonagem == 'copyWith') {
      pessoaClone = pessoas.elementAt(i).copyWith(
          sexo: sexoIndividuo,
          estadoCivil: estadoCivilIndividuo,
          idade: idadeIndividuo);
    } else {
      PessoaClone pessoaAnterior = pessoas.elementAt(i);
      pessoaClone = pessoaAnterior.clone();
      pessoaClone.sexo = sexoIndividuo ?? pessoaAnterior.sexo;
      pessoaClone.estadoCivil =
          estadoCivilIndividuo ?? pessoaAnterior.estadoCivil;
      pessoaClone.idade = idadeIndividuo ?? pessoaAnterior.idade;
    }

    pessoas.add(pessoaClone);
  }

  return pessoas.map((pessoa) => pessoa as Pessoa).toList();
}

Sexo getSexoAleatorio() {
  final int sexoSorteado = Random().nextInt(2);
  return sexoSorteado == 0 ? Sexo.masculino : Sexo.feminino;
}

EstadoCivil getEstadoCivilAleatorio() {
  final int estadoSorteado = Random().nextInt(4);

  switch (estadoSorteado) {
    case 0:
      return EstadoCivil.solteira;
    case 1:
      return EstadoCivil.casada;
    case 2:
      return EstadoCivil.separada;
    case 3:
      return EstadoCivil.viuva;
    default:
      throw Exception('Erro ao sortear o estado civil');
  }
}

int getIdadeAleatoria() {
  final int idadeSorteada = 18 + Random().nextInt(100 - 18);
  return idadeSorteada;
}

Map<String, int> getTotal(
    List<Pessoa> populacao, bool Function(Pessoa) criterioSelecao) {
  final int qtdePessoas = populacao.where(criterioSelecao).length;
  final int percentual = (qtdePessoas / populacao.length * 100).round();
  final Map<String, int> total = {
    'total': qtdePessoas,
    'percentual': percentual
  };

  return total;
}
