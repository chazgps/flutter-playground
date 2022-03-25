import 'task.dart';

abstract class TodoService {
  Future<void> init();

  Future<void> add(Task task);

  Future<void> delete(Task task);

  Future<void> update(Task task);

  Future<List<Task>> queryAll();
}
