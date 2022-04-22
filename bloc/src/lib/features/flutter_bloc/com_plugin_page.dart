import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../principal_event.dart';
import '../principal_state.dart';
import 'bloc_com_plugin.dart';

class ComPluginPage extends StatefulWidget {
  const ComPluginPage({Key? key}) : super(key: key);

  @override
  State<ComPluginPage> createState() => _ComPluginPageState();
}

class _ComPluginPageState extends State<ComPluginPage> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.amber),
      child: Scaffold(
        appBar: AppBar(title: const Text("Bloc com Plugin")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_getContador(), _getContador(), _getContador()],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton(
                heroTag: "removeComPlugin",
                child: const Icon(Icons.remove),
                onPressed: () {
                  context.read<BlocComPlugin>().add(DecrementoEvent());
                },
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: FloatingActionButton(
                heroTag: "addComPlugin",
                child: const Icon(Icons.add),
                onPressed: () {
                  context.read<BlocComPlugin>().add(IncrementoEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContador() {
    return BlocBuilder<BlocComPlugin, PrincipalState>(
      builder: (BuildContext context, PrincipalState state) {
        if (state is InitialState) {
          return _getContadorInicialWidget(state);
        }

        if (state is ContadorAtualizadoState) {
          return _getContadorAtualizadoWidget(state);
        }

        return _getContadorEstadoDesconhecidoWidget();
      },
    );
  }

  Widget _getContadorInicialWidget(InitialState estado) {
    return Text(estado.valor.toString(), style: const TextStyle(fontSize: 30));
  }

  Widget _getContadorAtualizadoWidget(ContadorAtualizadoState estado) {
    return Text(estado.valor.toString(), style: const TextStyle(fontSize: 30));
  }

  Widget _getContadorEstadoDesconhecidoWidget() {
    return const Text('Algo deu errado, estado desconhecido !');
  }
}
