import 'package:flutter/material.dart';

class Tema {
  static ThemeData getTemaClaro() {
    return ThemeData(
      primarySwatch: Colors.amber,
    );
  }

  static ThemeData getTemaEscuro() {
    const Color corBotao = Colors.green;
    const Color corTexto = Colors.white;


    return ThemeData.dark().copyWith(
      unselectedWidgetColor: Colors.green,
      toggleableActiveColor: Colors.green,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: corBotao,
          onPrimary: corTexto,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: corBotao,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: corTexto,
        backgroundColor: corBotao,
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
        color: corBotao,selectedColor:corBotao,
        fillColor: corBotao.withOpacity(0.2),
      ),bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: corBotao,
        unselectedItemColor: corTexto,
      ),
    );
  }
}
