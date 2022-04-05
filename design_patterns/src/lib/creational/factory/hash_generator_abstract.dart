/// Interface que define o contrato de um gerador de hash.
abstract class IHashGenerator {
  String hash(String text);
}
