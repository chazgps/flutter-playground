abstract class IMemoria {
  String get tipo;
  String get capacidade;
}

class MemoriaDDR1 extends IMemoria {
  @override
  String get tipo => 'DDR1';

  @override
  String get capacidade => '4GB';
}

class MemoriaDDR4 extends IMemoria {
@override
  String get tipo => 'DDR4';

  @override
  String get capacidade => '8GB';
}
