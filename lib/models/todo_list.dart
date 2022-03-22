import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:week4ex1/models/todo.dart';
import 'package:week4ex1/services/todo_datasource.dart';

class ToDoList extends ChangeNotifier {
  List<ToDo> _todos = [];

  UnmodifiableListView<ToDo> get todos => UnmodifiableListView(_todos);

  int get todoCount {
    int c = 0;
    for (var _t in _todos) {
      if (_t.complete == false) {
        c++;
      }
    }
    return c;
  }

  Future<void> refresh() async {
    _todos = await GetIt.I<TodoDatasource>().all();
  }

  Future<void> addToDo(ToDo toDo) async {
    GetIt.I<TodoDatasource>().addTodo(to0Do);
    notifyListeners();
  }

  Future<void> removeToDo(ToDo toDo) async {
    GetIt.I<TodoDatasource>().deleteTodo(toDo);
    notifyListeners();
  }

  // void addToDo(ToDo todo) {
  //   _todos.add(todo);
  //   notifyListeners();
  // }

  void updateToDo(ToDo todo) {
    ToDo listTodo = _todos.firstWhere((t) => t.name == todo.name);
    listTodo = todo;
    notifyListeners();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  // void removeToDo(ToDo todo) {
  //   _todos.remove(todo);
  //   notifyListeners();
  // }
}
