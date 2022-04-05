import 'dart:convert';
import 'package:cli/creational/factory/hash_generator_abstract.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';

class SHA1 implements IHashGenerator {
  @override
  String hash(String text) {
    var bytes = Utf8Encoder().convert(text);
    var digest = crypto.sha1.convert(bytes);
    var sha1 = hex.encode(digest.bytes);

    return sha1;
  }
}
