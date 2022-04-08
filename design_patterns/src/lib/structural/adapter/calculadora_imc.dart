import 'package:cli/structural/adapter/medidas.dart';

class CalculadoraIMC {
  int calculaIMC(Medidas medidas) {
    final double altura = medidas.getAltura() * medidas.getAltura();
    final double peso = medidas.getPeso();
    final int imc = peso ~/ altura;

    return imc;
  }

  String getClassificacao(int imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc >= 18.5 && imc <= 24.9) {
      return 'Peso normal';
    } else if (imc >= 25 && imc <= 29.9) {
      return 'Sobrepeso';
    } else if (imc >= 30 && imc <= 34.9) {
      return 'Obesidade grau I';
    } else if (imc >= 35 && imc <= 39.9) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }
}
