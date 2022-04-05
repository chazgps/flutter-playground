// ignore_for_file: constant_identifier_names

import 'package:cli/creational/abstract_factory/armazenamento.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

abstract class Computador {
  late CPU cpu;
  late Memoria memoria;
  late Armazenamento armazenamento;

  Computador(this.cpu, this.memoria, this.armazenamento);
}

class NoteBook extends Computador {
  NoteBook(CPU cpu, Memoria memoria, Armazenamento armazenamento)
      : super(cpu, memoria, armazenamento);
}

class Desktop extends Computador {
  Desktop(CPU cpu, Memoria memoria, Armazenamento armazenamento)
      : super(cpu, memoria, armazenamento);
}
