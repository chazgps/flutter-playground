import 'package:flutter/material.dart';
import 'principal_bloc.dart';
import 'principal_events.dart';
import 'principal_states.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  late final PrincipalBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = PrincipalBloc();
    _bloc.entrada.add(LoadingEvent());
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teste com Bloc")),
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
          Positioned( left: 30,
            bottom: 20,
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                _bloc.entrada.add(DecrementoEvent());
              },
            ),
          ),
          Positioned(bottom: 20,
            right: 30,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _bloc.entrada.add(IncrementoEvent());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContador() {
    return StreamBuilder(
      stream: _bloc.saida,
      builder: (BuildContext context, AsyncSnapshot<PrincipalState> snapshot) {
        if (snapshot.data is InitialState) {
          return _getContadorInicialWidget(snapshot.data as InitialState);
        }

        if (snapshot.data is ContadorAtualizadoState) {
          return _getContadorAtualizadoWidget(snapshot.data as ContadorAtualizadoState);
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
