import 'package:cli/factory/md5.dart';
import 'package:cli/factory/sha1.dart';

/// Interface que define o contrato de um gerador de hash.
abstract class IHashGenerator {
  String hash(String text);
}

/// Interface que define o contrato de uma fábrica de gerador de hash.
abstract class IHashGeneratorFactory {
  IHashGenerator createHashGenerator();
}

/// Classe que implementa a fábrica de gerador de hash MD5.
class MD5Factory implements IHashGeneratorFactory {
  @override
  IHashGenerator createHashGenerator() {
    return MD5();
  }
}

/// Classe que implementa a fábrica de gerador de hash SHA1.
class SHA1Factory implements IHashGeneratorFactory {
  @override
  IHashGenerator createHashGenerator() {
    return SHA1();
  }
}
