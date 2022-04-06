// ignore_for_file: constant_identifier_names

import 'package:cli/creational/abstract_factory/armazenamento.dart';
import 'package:cli/creational/abstract_factory/cpu.dart';
import 'package:cli/creational/abstract_factory/memoria.dart';

abstract class IComputador {
  late ICPU cpu;
  late IMemoria memoria;
  late IArmazenamento armazenamento;

  IComputador(this.cpu, this.memoria, this.armazenamento);
}

class NoteBook extends IComputador {
  NoteBook(ICPU cpu, IMemoria memoria, IArmazenamento armazenamento)
      : super(cpu, memoria, armazenamento);
}

class Desktop extends IComputador {
  Desktop(ICPU cpu, IMemoria memoria, IArmazenamento armazenamento)
      : super(cpu, memoria, armazenamento);
}
