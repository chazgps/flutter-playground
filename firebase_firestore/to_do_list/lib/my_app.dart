import 'package:flutter/material.dart';
import 'package:to_do_list/service/todo_service.dart';
import 'principal_page.dart';

class MyApp extends StatelessWidget {
  late final TodoService _todoService;

  MyApp(TodoService todoService){
    _todoService = todoService;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrincipalPage(_todoService),
    );
  }
}