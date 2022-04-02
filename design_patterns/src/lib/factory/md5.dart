import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:cli/factory/hash_generator_abstract.dart';
import 'package:crypto/crypto.dart' as crypto;

class MD5 implements IHashGenerator {
  @override
  String hash(String text) {
    var bytes = Utf8Encoder().convert(text);
    var digest = crypto.md5.convert(bytes);
    var md5 = hex.encode(digest.bytes);

    return md5;
  }
}
