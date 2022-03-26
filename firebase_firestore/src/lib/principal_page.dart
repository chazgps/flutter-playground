import 'package:flutter/material.dart';
import 'app.dart';
import 'service/task.dart';
import 'service/todo_service.dart';
import 'componentes.dart' as ui;

class PrincipalPage extends StatelessWidget {
  late final TodoService _todoService;
  late final App _app;

  PrincipalPage(this._app, this._todoService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: _getCorpoPagina(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _insereTarefa(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _getCorpoPagina(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<Task>>(
        future: _todoService.queryAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
          if (snapshot.hasError) {
            return _getMensagemErro(context, snapshot.error);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return _getListaTarefas(context, snapshot.data!);
          }

          return _getMensagemEspera();
        },
      ),
    );
  }

  AlertDialog _getMensagemErro(BuildContext context, error) {
    final String mensagem = error.message.toString();
    return ui.exibeMensagem(context, 'Erro', mensagem);
  }

  Widget _getMensagemEspera() {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(strokeWidth: 8,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _getListaTarefas(BuildContext context, List<Task> tasks) {
    _app.tasks.value = tasks;

    return ValueListenableBuilder(
      valueListenable: _app.tasks,
      builder: (BuildContext context, List<Task> value, Widget? child) {
        return ListView.builder(
          itemCount: _app.tasks.value.length,
          itemBuilder: (BuildContext context, int index) {
            final Task task = _app.tasks.value.elementAt(index);
            final String mensagem = task.description;
            final String subtitulo = 'id: ${task.id}';

            return Dismissible(
              onDismissed: (DismissDirection direction) {
                _apagaTarefa(context, task);
              },
              key: UniqueKey(),
              child: ListTile(
                  title: Text(mensagem),
                  subtitle: Text(subtitulo),
                  onTap: () => _alteraTarefaDialog(context, task)),
            );
          },
        );
      },
    );
  }

  void _insereTarefa(BuildContext context) async {
    ui.inputDialog(context, titulo: 'Nova tarefa', onSubmit: (String tarefa) {
      final Task task = Task(tarefa);

      _todoService.add(task).then((value) {
        debugPrint('Tarefa criada id => ' + task.id);

        _app.tasks.value = List.from(_app.tasks.value)..add(task);

        ui.showSnackBar(context, 'Tarefa criada !');
      });
    });
  }

  void _apagaTarefa(BuildContext context, Task task) {
    _todoService.delete(task).then((value) {
      _app.tasks.value = List.from(_app.tasks.value)..remove(task);

      ui.showSnackBar(context, 'Tarefa apagada !');
    });
  }

  void _alteraTarefaDialog(BuildContext context, Task task) async {
    ui.inputDialog(context,
        titulo: 'Alterar tarefa',
        initialValue: task.description, onSubmit: (valor) {
      // Vamos fazer uma cópia da Task para não atualizar o objeto
      // original ainda...só atualizaremos se a operação tiver sucesso
      Task clone = task.copyWith(id: task.id, description: valor);

      _todoService.update(clone).then((value) {
        task.description = valor;

        _app.tasks.value = List.from(_app.tasks.value);

        ui.showSnackBar(context, 'Tarefa alterada !');
      });
    });
  }
}
