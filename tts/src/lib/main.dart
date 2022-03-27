import 'package:flutter/material.dart';
import 'package:tts/tts/flutter_tts.dart';
import 'package:tts/my_app.dart';
import 'package:tts/tts/tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final TTS _tts = FlutterTTSImpl();
  await _tts.init();

  runApp(MyApp(_tts));
}
