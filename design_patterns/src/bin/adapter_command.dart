import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:cli/structural/adapter/calculadora_imc.dart';
import 'package:cli/structural/adapter/conversor.dart';
import 'package:cli/structural/adapter/medidas.dart';
import 'package:cli/structural/adapter/medidas_inglesas.dart';
import 'package:intl/intl.dart';

class AdapterCommand extends Command {
  @override
  String get name => 'adapter';

  @override
  String get description => 'Teste do padrão Adapter';

  AdapterCommand() {
    argParser.addOption('adapter');
  }

  @override
  void run() {
    final String titulo = "Design Pattern: Adapter";

    print(titulo);
    print(''.padRight(titulo.length, '=') + '\n');

    final NumberFormat formatadorNumero = NumberFormat("###.0#", "pt_BR");

    double pesoUsuario;
    double alturaUsuario;

    print('Qual é o seu peso em kilos ?');
    String? peso = stdin.readLineSync();

    try {
      pesoUsuario = formatadorNumero.parse(peso!).toDouble();
    } catch (e) {
      print('Peso inválido !');
      return;
    }

    print('Qual a sua altura em centímetros (Ex: 1,80');

    String? altura = stdin.readLineSync();

    try {
      alturaUsuario = formatadorNumero.parse(altura!).toDouble();
    } catch (e) {
      print('Altura inválida !');
      return;
    }

    // -------------------------------------------------
    final CalculadoraIMC calculadora = CalculadoraIMC();

    // Vamos criar um objeto para armazenar as medidas do usuário
    // assumindo que ele informou no sistema Universal de medidas
    // Peso em Kilos e Altura em Metros.
    final Medidas medidasUsuario =
        Medidas(altura: alturaUsuario, peso: pesoUsuario);

    final int imc = calculadora.calculaIMC(medidasUsuario);
    final String classificacao = calculadora.getClassificacao(imc);

    print('Você pesa $pesoUsuario kilos e tem ${alturaUsuario}m de altura.');
    print('Seu IMC é $imc e sua classificação é $classificacao.');

    // -------------------------------------------------
    // Agora usando o adapter simulando que nossa calculadora está
    // sendo usada por uma aplicação nos EUA e o usuário usou as medidas
    // de altura e peso de lá (sistema inglês)

    final double alturaEmFeets = Conversor.getFeetsFromMetros(alturaUsuario);
    final double pesoEmPounds = Conversor.getPoundsFromKilos(pesoUsuario);

    final Medidas medidasUsuarioEmIngles =
        Medidas(altura: alturaEmFeets, peso: pesoEmPounds);
    final MedidasInglesasAdapter adapter =
        MedidasInglesasAdapter(medidasUsuarioEmIngles);

    final int imcNovo = calculadora.calculaIMC(adapter);

    print(
        '\nNos EUA seu peso seria de $pesoEmPounds pounds e sua altura seria $alturaEmFeets feets.');
    print('Seu IMC continuaria sendo $imcNovo.');
  }
}
