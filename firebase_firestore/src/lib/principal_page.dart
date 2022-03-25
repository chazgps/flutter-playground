import 'dart:async';

import 'package:flutter/material.dart';
import 'app.dart';
import 'service/task.dart';
import 'service/todo_service.dart';

class PrincipalPage extends StatefulWidget {
  late final TodoService _todoService;
  late final App _app;

  PrincipalPage(App app, TodoService todoService, {Key? key}) : super(key: key) {
    _app = app;
    _todoService = todoService;
  }

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  _PrincipalPageState() {
    debugPrint('constructor');
  }

  @override
  void initState() {
    super.initState();
    debugPrint('initState');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: _getCorpoPagina(),
      floatingActionButton: FloatingActionButton(
        onPressed: _insereTarefa,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _getCorpoPagina() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<Task>>(
        future: widget._todoService.queryAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasError) {
            return _getMensagemErro(snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return _getListaTarefas(snapshot.data!);
          }

          return _getMensagemEspera();
        },
      ),
    );
  }

  AlertDialog _getMensagemErro(error) {
    final String mensagem = error.message.toString();
    return _exibeMensagem(context, 'Erro', mensagem);
  }

  AlertDialog _exibeMensagem(BuildContext context, String titulo, String mensagem) {
    return _getAlertDialog(
      titulo,
      Text(mensagem),
      [
        _getBotao('OK', onTap: () {
          Navigator.of(context).pop();
        })
      ],
    );
  }

  Future<void> _inputDialog(BuildContext context,
      {required String titulo, required Function(String) onSubmit, required VoidCallback onCancel}) async {
    TextEditingController textFieldController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          final TextField campo = TextField(
            controller: textFieldController,
          );

          VoidCallback callbackOK = () {
            onSubmit(textFieldController.text);
          };

          VoidCallback callbackCancelar = () {
            onCancel();
          };

          final List<TextButton> botoes = [_getBotao('OK', onTap: callbackOK), _getBotao('Cancelar', onTap: callbackCancelar)];

          return _getAlertDialog(titulo, campo, botoes);
        });
  }

  _getAlertDialog(String titulo, Widget corpo, List<TextButton> botoes) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.all(20),
      title: Text(titulo),
      content: corpo,
      actions: botoes,
    );
  }

  TextButton _getBotao(String titulo, {required VoidCallback onTap}) {
    return TextButton(
      child: Text(titulo),
      onPressed: () {
        onTap();
      },
    );
  }

  Widget _getMensagemEspera() {
    return SizedBox(
      height: 100,
      width: 100,
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }

  Widget _getListaTarefas(List<Task> tasks) {
    widget._app.tasks.value = tasks;

    return ValueListenableBuilder(
      valueListenable: widget._app.tasks,
      builder: (BuildContext context, List<Task> value, Widget? child) {
        return ListView.builder(
          itemCount: widget._app.tasks.value.length,
          itemBuilder: (BuildContext context, int index) {
            final Task task = widget._app.tasks.value.elementAt(index);
            final String mensagem = task.id + ' - ' + task.description;

            return Dismissible(
              onDismissed: (DismissDirection direction) {
                _apagaTarefa(context, task);
              },
              key: UniqueKey(),
              child: ListTile(title: Text(mensagem)),
            );
          },
        );
      },
    );
  }

  void _insereTarefa() async {
    _inputDialog(context, titulo: 'Nova tarefa', onSubmit: _cadastraTarefa, onCancel: _desisteCadastro);
  }

  void _cadastraTarefa(String tarefa) {
    Navigator.pop(context);

    final Task task = Task(tarefa);

    widget._todoService.add(task).then((value) {
      debugPrint('Tarefa criada id => ' + task.id);

      widget._app.tasks.value = List.from(widget._app.tasks.value)..add(task);

      _showSnackBar('Tarefa criada !');
    });
  }

  void _desisteCadastro() {
    Navigator.pop(context);
  }

  void _apagaTarefa(BuildContext context, Task task) {
    widget._todoService.delete(task).then((value) {
      widget._app.tasks.value = List.from(widget._app.tasks.value)..remove(task);

      _showSnackBar('Tarefa apagada !');
    });
  }

  void _showSnackBar(String mensagem) {
    final SnackBar snackBar = SnackBar(
      content: Text(mensagem, style: TextStyle(fontSize: 20)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
