/// Classe para armazenar medidas, não explicitamente expressas
/// em algum sistema de medidas como o sistema Universal ou Inglês
/// https://pt.wikipedia.org/wiki/Sistema_Internacional_de_Unidades
/// https://pt.wikipedia.org/wiki/Unidade_inglesa
class Medidas {
  late double _altura;

  late double _peso;

  Medidas({required double altura, required double peso}) {
    _altura = altura;
    _peso = peso;
  }

  double getAltura() => _altura;

  double getPeso() => _peso;
}
