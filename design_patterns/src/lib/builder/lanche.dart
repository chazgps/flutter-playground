import 'package:cli/builder/ingrediente.dart';

class Lanche {
  late final List<Ingrediente> _ingredientes;
  late final String _nome;

  Lanche(String nome) {
    _nome = nome;
    _ingredientes = [];
  }

  void adicionarIngrediente(Ingrediente ingrediente) {
    _ingredientes.add(ingrediente);
  }

  String get ingredientes => _ingredientes.map((ingrediente) {
        return ingrediente.nome + '(' + ingrediente.preco.toStringAsFixed(2) + ')';
      }).join(', ');

  String get nome => _nome;

  String get preco {
    double preco = 0.0;

    for (var ingrediente in _ingredientes) {
      preco += ingrediente.preco;
    }

    return preco.toStringAsFixed(2);
  }
}