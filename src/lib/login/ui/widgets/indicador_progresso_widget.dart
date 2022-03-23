import 'package:flutter/material.dart';

class IndicadorProgresso extends StatelessWidget {
  late final bool _visivel;
  late final String? _mensagem;
  late Color? _color;

  IndicadorProgresso({Key? key, required bool visivel, String? mensagem, Color? color}) : super(key: key) {
    _visivel = visivel;
    _mensagem = mensagem;
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    _color ??= Theme.of(context).indicatorColor;

    return Visibility(
      visible: _visivel,
      // ignore: sized_box_for_whitespace
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_mensagem != null) ...[
                Text(
                  _mensagem!,
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
              ],
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 70, maxHeight: 70, minWidth: 70, maxWidth: 70),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_color!),
                  strokeWidth: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
