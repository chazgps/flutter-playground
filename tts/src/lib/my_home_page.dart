import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tts/tts/tts.dart';

class MyHomePage extends StatefulWidget {
  late final TTS _tts;

  MyHomePage(TTS tts, {Key? key}) : super(key: key) {
    _tts = tts;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;

  String _linguagem = '';
  double _volume = 1.0;
  double _velocidade = 1.0;
  double _pitch = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = 'Olá pessoal !';

    if (widget._tts.isInitialized) {
      _linguagem = widget._tts.getDefaultLanguage();
    } else {
      _linguagem = 'Não disponível';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste com Síntese de Voz (TTS)'),
      ),
      body: _getCorpoPagina(),
    );
  }

  Widget _getCorpoPagina() {
    if (!widget._tts.isInitialized) {
      return _getTtsNaoDisponivel();
    }

    return CustomScrollView(slivers: [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: <Widget>[
            _getCampoTexto(),
            SizedBox(height: 10),
            _getPainel('Linguagem', child: _getComboLinguagens()),
            SizedBox(height: 10),
            _getPainel('Volume',
                child: _getSlider(0, 1, _volume, (valor) {
                  _volume = valor;
                })),
            SizedBox(height: 10),
            _getPainel('Velocidade',
                child: _getSlider(0, 1, _velocidade, (valor) {
                  _velocidade = valor;
                })),
            SizedBox(height: 10),
            _getPainel('Pitch',
                child: _getSlider(0.5, 2, _pitch, (valor) {
                  _pitch = valor;
                })),
          ]),
        ),
      ),
    ]);
  }

  Widget _getTtsNaoDisponivel() {
    final String mensagem =
        'A Síntese de Texto para Fala (Text-to-Speech) não está disponível.'
        '\n\nIsto pode ocorrer porque o celular está mal-configurado na parte de síntese de voz '
        'ou não há nenhuma voz instalada.'
        '\n\nVerifique sua configuração e volte ao aplicativo quando estiver funcionando.';

    final TextButton botaoSair = TextButton(
      child: Text('Sair'),
      onPressed: () {
        debugPrint('Encerrando a aplicação...');
        exit(0);
      },
    );

    return Container(
      color: Colors.red[900],
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: _getAlertDialog(
            'Erro', Text(mensagem, style: TextStyle(fontSize: 16)),
            botoes: [botaoSair]),
      ),
    );
  }

  Widget _getCampoTexto() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(fontSize: 26),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Digite um texto qualquer',
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: _ouvirTexto,
            ),
          )
        ],
      ),
    );
  }

  Widget _getComboLinguagens() {
    final List<String> linguagens;

    if (widget._tts.isInitialized) {
      linguagens = widget._tts.getInstalledLangages();
    } else {
      linguagens = [_linguagem];
    }

    return DropdownButton<String>(
      value: _linguagem,
      icon: Icon(Icons.arrow_downward, color: Theme.of(context).primaryColor),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String? valorSelecionado) {
        setState(() {
          _linguagem = valorSelecionado!;
        });
      },
      items: linguagens.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _getPainel(String label, {required Widget child}) {
    return Container(
      constraints: BoxConstraints(minWidth: 400),
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          child
        ],
      ),
    );
  }

  Widget _getSlider(double min, double max, double valor,
      Function(double) funcaoAtualizacao) {
    return Slider(
      min: min,
      max: max,
      value: valor,
      onChanged: (valor) {
        setState(() {
          funcaoAtualizacao(valor);
        });
      },
    );
  }

  AlertDialog _getAlertDialog(String titulo, Widget corpo,
      {List<TextButton>? botoes}) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      title: Text(titulo),
      content: corpo,
      actions: botoes,
    );
  }

  void _ouvirTexto() async {
    await widget._tts.setLanguage(_linguagem);
    await widget._tts.setSpeed(_velocidade);
    await widget._tts.setVolume(_volume);
    await widget._tts.setPitch(_pitch);
    widget._tts.speak(_controller.text);
  }
}
