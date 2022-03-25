import 'package:flutter/material.dart';

import 'cronometro_regressivo.dart';
import 'pages/tela1_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CronometroRegressivo _cronometro = CronometroRegressivo(minutos: 1);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Tela1(_cronometro));
  }
}
