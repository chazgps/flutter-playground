import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/service/task.dart';
import 'package:to_do_list/service/todo_service.dart';

class FirebaseTodoService implements TodoService {
  late FirebaseFirestore _firestore;
  late CollectionReference? _tasks;
  static const String collectionName = 'tasks';

  FirebaseTodoService() {
    _tasks = null;
  }

  @override
  Future<void> init() async {
    try {
      final FirebaseApp firebaseApp = await Firebase.initializeApp();

      final List<FirebaseApp> apps = Firebase.apps;
      debugPrint('Currently initialized apps: $apps');

      final FirebaseOptions options = firebaseApp.options;
      debugPrint('Current options for app: $options');

      _firestore = FirebaseFirestore.instanceFor(app: firebaseApp);
      _tasks = _firestore.collection(collectionName);
    } catch (e) {
      debugPrint('Firebase init: ' + e.toString());

      throw Exception('Falha na inicialização do Firebase -> ' + e.toString());
    }
  }

  @override
  Future<void> add(Task task) async {
    assert(_tasks != null, 'FirebaseTodoService não foi inicializado via init()');

    try {
      final Map<String, dynamic> campos = {'description': task.description};
      final DocumentReference document = await _tasks!.add(campos);

      task.id = document.id;
    } catch (e) {
      throw Exception('insert: ' + e.toString());
    }
  }

  @override
  Future<void> delete(Task task) async {
    assert(_tasks != null, 'FirebaseTodoService não foi inicializado via init()');

    try {
      await _firestore.runTransaction((Transaction myTransaction) async {
        final DocumentReference document = _tasks!.doc(task.id);

        myTransaction.delete(document);
      });
    } catch (e) {
      throw Exception('delete: ' + e.toString());
    }
  }

  @override
  Future<void> update(Task task) async {
    assert(_tasks != null, 'FirebaseTodoService não foi inicializado via init()');

    try {
      final DocumentReference document = _tasks!.doc(task.id);
      final Map<String, String> campos = {'description': task.description};

      document.update(campos);
    } catch (e) {
      throw Exception('update: ' + e.toString());
    }
  }

  @override
  Future<List<Task>> queryAll() async {
    assert(_tasks != null, 'FirebaseTodoService não foi inicializado via init()');

    try {
      final QuerySnapshot querySnapshot = await _tasks!.get();
      final List<Task> tasks = [];

      querySnapshot.docs.forEach((doc) {
        final Task task = Task(doc['description']);
        task.id=doc.id;
        tasks.add(task);
      });

      return tasks;
    } catch (e) {
      throw Exception('queryAll: ' + e.toString());
    }
  }
}
