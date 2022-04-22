import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_block/features/flutter_bloc/bloc_com_plugin.dart';
import 'package:teste_block/features/principal_event.dart';
import 'features/bloc_puro/principal_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final BlocComPlugin _bloc = BlocComPlugin();
    _bloc.add(LoadingEvent());

    return BlocProvider<BlocComPlugin>.value(
      value:_bloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PrincipalPage(),
      ),
    );
  }
}
