import 'package:flutter/material.dart';

import 'service/task.dart';

class App {
  late ValueNotifier<List<Task>> tasks;

  App(){
    tasks = ValueNotifier<List<Task>>([]);
  }
}