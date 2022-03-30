import 'package:flutter/material.dart';
import 'package:tema_escuro/configuracoes.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tema ' + _getNomeTema()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _getSeletorTema(),
            _getBotoes(),
            _getBotoesOutlined(),
            _getChips(),
            _getCheckbox(),
            _getSwitch(),
            _getBotoesToggle(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  String _getNomeTema() {
    String nomeTema;

    switch (Configuracoes.tema.value) {
      case ThemeMode.system:
        nomeTema = 'Sistema';
        break;
      case ThemeMode.light:
        nomeTema = 'Claro';
        break;
      case ThemeMode.dark:
        nomeTema = 'Escuro';
    }
    return nomeTema;
  }

  Widget _getSeletorTema() {
    return Row(
      children: [
        _getRadio('Sistema', ThemeMode.system),
        _getRadio('Claro', ThemeMode.light),
        _getRadio('Escuro', ThemeMode.dark)
      ],
    );
  }

  Widget _getRadio(String nomeTema, ThemeMode valor) {
    return Expanded(
      flex: 1,
      child: InkWell(
        splashColor: Colors.yellow[100],
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enableFeedback: true,
        onTap: () {
          Configuracoes.tema.value = valor;
        },
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: Configuracoes.tema,
              builder: (context, ThemeMode tema, child) {
                return Radio<ThemeMode>(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: valor,
                  groupValue: Configuracoes.tema.value,
                  onChanged: (ThemeMode? novoTema) {
                    Configuracoes.tema.value = novoTema!;
                  },
                );
              },
            ),
            Text(nomeTema)
          ],
        ),
      ),
    );
  }

  Widget _getBotoes() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(onPressed: () {}, child: const Text('Ativo')),
          ),
          const SizedBox(width: 20),
          const Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: null,
              child: Text('Inativo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBotoesOutlined() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child:
                OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
          ),
          const SizedBox(width: 20),
          const Expanded(
            flex: 1,
            child: OutlinedButton(
                onPressed: null, child: Text('Outlined inativo')),
          ),
        ],
      ),
    );
  }

  Widget _getBotoesToggle() {
    final ValueNotifier<List<bool>> estadoBotoes =
        ValueNotifier<List<bool>>([true, false, true]);

    return ValueListenableBuilder(
      valueListenable: estadoBotoes,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ToggleButtons(
            isSelected: estadoBotoes.value,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                  width: 70, height: 70, child: const Icon(Icons.fast_rewind)),
              // ignore: sized_box_for_whitespace
              Container(
                  width: 70, height: 70, child: const Icon(Icons.favorite)),
              // ignore: sized_box_for_whitespace
              Container(
                  width: 70, height: 70, child: const Icon(Icons.fast_forward)),
            ],
            onPressed: (int index) {
              estadoBotoes.value[index] = !estadoBotoes.value[index];
              estadoBotoes.value = estadoBotoes.value.toList();
            },
          ),
        );
      },
    );
  }

  Widget _getBottomNavigationBar() {
    final ValueNotifier<int> indiceAtual = ValueNotifier<int>(0);

    return ValueListenableBuilder(
      valueListenable: indiceAtual,
      builder: (context, value, child) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
          currentIndex: indiceAtual.value,
          onTap: (int index) {
            indiceAtual.value = index;
          },
        );
      },
    );
  }

  Widget _getChips() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _getChip('Dart'),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: _getChip('Flutter'),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: _getChip('Dash'),
          ),
        ],
      ),
    );
  }

  Widget _getChip(String texto) {
    return Chip(
      label: Text(texto),
      labelPadding: const EdgeInsets.only(left: 10, right: 10),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(texto[0].toUpperCase()),
      ),
    );
  }

  Widget _getCheckbox() {
    final ValueNotifier<bool> estadoCheckbox = ValueNotifier<bool>(false);

    return ValueListenableBuilder(
      valueListenable: estadoCheckbox,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: estadoCheckbox.value,
            onChanged: (bool? novoValor) {
              estadoCheckbox.value = novoValor!;
            },
            title: Transform.translate(
                offset: const Offset(-20, 0),
                child: const Text('Manter-se conectado')),
            selected: estadoCheckbox.value,
          ),
        );
      },
    );
  }

  Widget _getSwitch() {
    final ValueNotifier<bool> estadoSwitch = ValueNotifier<bool>(false);

    return ValueListenableBuilder(
      valueListenable: estadoSwitch,
      builder: (context, value, child) {
        return SwitchListTile(
          value: estadoSwitch.value,
          onChanged: (bool? novoValor) {
            estadoSwitch.value = novoValor!;
          },
          title: const Text('Desligar notificações'),
          selected: estadoSwitch.value,
        );
      },
    );
  }
}
