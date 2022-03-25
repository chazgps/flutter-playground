import 'package:flutter/material.dart';
import 'package:to_do_list/service/todo_service.dart';
import 'app.dart';
import 'principal_page.dart';

class MyApp extends StatelessWidget {
  late final App _app;
  late final TodoService _todoService;

  MyApp(App app, TodoService todoService) {
    _app = app;
    _todoService = todoService;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrincipalPage(_app, _todoService),
    );
  }
}
