abstract class IArmazenamento {
  String get tipo;
  String get velocidade;
}

class ArmazenamentoHDD extends IArmazenamento {
  @override
  String get tipo => 'HDD';

  @override
  String get velocidade => '50 MB/s para escrita, e até 120 MB/s para leitura';
}

class ArmazenamentoSSD extends IArmazenamento {
  @override
  String get tipo => 'SSD';

  @override
  String get velocidade => '440 MB/s para escrita, e até 530 MB/s para leitura';
}
