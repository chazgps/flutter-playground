import 'package:cli/structural/adapter/conversor.dart';
import 'package:cli/structural/adapter/medidas.dart';

class MedidasInglesasAdapter implements Medidas {
  late Medidas _medidas;

  /// Recebe um objeto Medidas expressas no sistema Inglês
  MedidasInglesasAdapter(Medidas medidas) {
    _medidas = medidas;
  }

  @override
  double getAltura() {
    double alturaEmMetros = Conversor.getMetrosFromFeets(_medidas.getAltura());
    return alturaEmMetros;
  }

  @override
  double getPeso() {
    final double pesoMetrico = Conversor.getKilosFromPounds(_medidas.getPeso());
    return pesoMetrico;
  }
}
