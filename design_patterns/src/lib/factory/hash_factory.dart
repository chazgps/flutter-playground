import 'package:cli/factory/hash_generator_abstract.dart';
import 'package:cli/factory/md5.dart';

import 'sha1.dart';

/// Tipos de gerador de hash que a factory sabe criar.
enum hashType {
  md5,
  sha1,
}

/// Vamos criar um objeto implementando o padrão Factory e Singleton
class HashFactory {
  // O membro estático guarda a única instância da classe
  static final HashFactory _factory = HashFactory._internal();

  // Um construtor privado impede que outras instâncias sejam criadas
  HashFactory._internal();

  // Não importa quantas vezes tentarem instanciar uma classe, sempre
  // retornará o mesmo objeto.
  factory HashFactory() => _factory;

  IHashGenerator getHashGenerator(hashType type) {
    switch (type) {
      case hashType.md5:
        return MD5();
      case hashType.sha1:
        return SHA1();
      default:
        throw Exception('Função de Hash inválida');
    }
  }
}
