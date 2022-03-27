import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tts/tts/tts.dart';

class FlutterTTSImpl implements TTS {
  late FlutterTts _flutterTts;
  late bool _inicializado;
  late String _linguagemPadrao;
  late List<String> _linguagensInstaladas;

  FlutterTTSImpl() {
    _inicializado = false;
    _linguagensInstaladas = [];
  }

  @override
  Future<void> init() async {
    _flutterTts = FlutterTts();

    var linguagensInstaladas = await _flutterTts.getLanguages;

    if (linguagensInstaladas != null) {
      for (var linguagem in linguagensInstaladas) {
        _linguagensInstaladas.add(linguagem);
      }
      _linguagensInstaladas.sort();
      debugPrint(_linguagensInstaladas.toString());
    }

    if (linguagensInstaladas.indexOf('pt-BR') != -1) {
      _linguagemPadrao = 'pt-BR';
    } else {
      debugPrint('Não há suporte para o idioma pt-BR');

      if (linguagensInstaladas.indexOf('en-US') != -1) {
        _linguagemPadrao = 'en-US';
      } else {
        debugPrint('Não há suporte para pt-BR ou en-US');
        return;
      }
    }

    await _flutterTts.setLanguage(_linguagemPadrao);

    _inicializado = true;
  }

  @override
  bool get isInitialized => _inicializado;

  @override
  List<String> getInstalledLangages() => _linguagensInstaladas;

  @override
  String getDefaultLanguage() {
    if (!_inicializado) {
      throw Exception('TTS não inicializado');
    }

    return _linguagemPadrao;
  }

  @override
  Future<void> setLanguage(String language) {
    return _flutterTts.setLanguage(language);
  }

  @override
  Future<void> setSpeed(double speed) async {
    if (!_inicializado) return;
    if (speed < 0) {
      speed = 0;
    } else if (speed > 1) speed = 1;

    return _flutterTts.setSpeechRate(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    if (!_inicializado) return;
    if (volume < 0) {
      volume = 0;
    } else if (volume > 1) volume = 1;

    return _flutterTts.setVolume(volume);
  }

  @override
  Future<void> setPitch(double pitch) async {
    if (!_inicializado) return;
    if (pitch < 0.5) {
      pitch = 0.5;
    } else if (pitch > 2) pitch = 2;

    return _flutterTts.setPitch(pitch);
  }

  @override
  Future<void> speak(String sentence) async {
    if (!_inicializado) return;

    return _flutterTts.speak(sentence);
  }
}
