import 'package:flutter/material.dart';
import 'package:tts/tts/tts.dart';

import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  late final TTS _tts;

  MyApp(TTS tts, {Key? key}) : super(key: key) {
    _tts = tts;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: MyHomePage(_tts),
    );
  }
}
