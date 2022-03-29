import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:week4ex1/models/todo.dart';
import 'package:week4ex1/services/todo_datasource.dart';

class ToDoList extends ChangeNotifier {
  List<ToDo> _todos = [];

  UnmodifiableListView<ToDo> get todos => UnmodifiableListView(_todos);

  int get todoCount {
    return _todos.where((i) => i.complete == false).length;
  }

  Future<void> refresh() async {
    _todos = await GetIt.I<TodoDatasource>().all();
    notifyListeners();
  }

  Future<void> addToDo(ToDo toDo) async {
    await GetIt.I<TodoDatasource>().addTodo(toDo);
    refresh();
  }

  Future<void> removeToDo(ToDo toDo) async {
    GetIt.I<TodoDatasource>().deleteTodo(toDo);
    refresh();
  }

  Future<void> removeAll() async {
    GetIt.I<TodoDatasource>().deleteAll();
    refresh();
  }

  Future<void> updateToDo(ToDo toDo) async {
    GetIt.I<TodoDatasource>().updateTodo(toDo);
    refresh();
  }
}
