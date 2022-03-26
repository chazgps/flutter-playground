import 'package:flutter/foundation.dart';

class Log extends ChangeNotifier {
  List<String> _eventos = [];

  List<String> get eventos => _eventos;

  void add(String valor){
    _eventos.add(valor);
    notifyListeners();
  }
}
