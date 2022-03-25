import 'package:flutter/material.dart';

import 'app.dart';
import 'my_app.dart';
import 'service/firebase_todo_service.dart';
import 'service/todo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final TodoService todoService = FirebaseTodoService();
  await todoService.init();

  final App app=App();

  runApp(MyApp(app,todoService));
}

