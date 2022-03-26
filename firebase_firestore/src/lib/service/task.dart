class Task {
  late String id;
  late String description;

  Task(this.description);

  copyWith({required String id,required String description}) {
    Task task = Task(description);
    task.id = id;
    return task;
  }
}
